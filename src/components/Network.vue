<template>
    <div class="top-level-container">
        <div v-show="this.nodeLength != 0" class="viz" ref="visualization"></div>
        <div v-show="this.nodeLength == 0" v-bind:class="[isMobile ? 'msg-wrapper-mobile' : 'msg-wrapper']">
            <h2>Enter search keywords to get a graph</h2>
            <h3><i>Graph properties</i></h3>
            <p>
                The graph structure is <b>a backbone of {{ this.backboneType }}s</b>
                <span v-show="this.starTypes"> with <b>stars of {{ this.starTypes }}</b> from a backbone node.</span>
            </p>
            <p>A node size is proportional to its popularity.</p>
            <p>Each color group represents star nodes related to the same backbone node.</p>
            <h3><i>Interactions</i></h3>
            <p>
                <i v-show="isMobile">Click - </i>
                <i v-show="!isMobile">Hover - </i>
                Play track preview
            </p>
            <p><i>Double Click - </i>Expand graph around outside node</p>
            <p v-show="!isMobile"><i>Shift Click - </i>Open Deezer</p>
            <p v-show="!isMobile"><i>Alt/Option Click - </i>Delete node and its successors</p>
        </div>
    </div>
</template>


<style lang='stylus'>
@import('https://cdn.jsdelivr.net/npm/vis@4.21.0-EOL/dist/vis.min.css')

.top-level-container {
position: absolute;
top: 0;
z-index: 1;
width: 100vw;
}

.viz {
height: 100vh;
display:flex;
top: 0px;
left: 0px;
display:flex;
z-index: 1;
align-items: center;
justify-content: center;
vertical-align: center;
}

.msg-wrapper {
z-index: 2;
width: 100%;
height: 100vh;
display:flex;
flex-direction: column; /* Stack items vertically */
align-items: center;
justify-content: center;
vertical-align: center;
text-align: center;

p, h3 {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
}

h2 {
    font-size: 30px;
    font-style: oblique;
}

p, h2, h3 {
    color: #888888;
}
}

.msg-wrapper-mobile {
    z-index: 2;
    width: 100%;
    height: 100vh;
    display:flex;
    flex-direction: column; /* Stack items vertically */
    align-items: center;
    justify-content: center;
    vertical-align: center;
    text-align: center;

    p, h3 {
        font-family: 'Avenir', Helvetica, Arial, sans-serif;
    }

    h2 {
        font-size: 18px;
        font-style: oblique;
    }

    p {
        font-size: 12px;
    }

    p, h2, h3 {
        color: #888888;
    }
    }
</style>
  
<script>
import { Network } from "vis-network";
import { DataSet } from "vis-data";
import { mountVisData, translateEvent } from "../lib/utils";

export default {
name: "NetworkVue",
props: {
    edges: {
        type: [Array, DataSet, DataView],
        default: () =>  []
    },
    nodes: {
        type: [Array, DataSet, DataView],
        default: () => []
    },
    events: {
        type: Array,
        default: () => [
            "click",
            "doubleClick",
            "oncontext",
            "hold",
            "release",
            "select",
            "selectNode",
            "selectEdge",
            "deselectNode",
            "deselectEdge",
            "dragStart",
            "dragging",
            "dragEnd",
            "hoverNode",
            "blurNode",
            "hoverEdge",
            "blurEdge",
            "zoom",
            "showPopup",
            "hidePopup",
            "startStabilizing",
            "stabilizationProgress",
            "stabilizationIterationsDone",
            "stabilized",
            "resize",
            "initRedraw",
            "beforeDrawing",
            "afterDrawing",
            "animationFinished",
            "configChange"
        ]
    },
    options: {
        type: Object,
        default: () => ({})
    },
    selectedTypes: {
        type: [Array],
        default: () => ["album", "artist", "track"]
    },
    isMobile: {
        type: [Boolean],
        default: false
    }
},
data: () => ({
    visData: {
    nodes: null,
    edges: null
    },
    length: 0
}),
computed: {
    nodeLength: function () {
        return this.visData.nodes?.length ?? 0;
    },
    backboneType: function() {
        if (this.selectedTypes.includes('artist')) {
            return 'artist';
        } else if (this.selectedTypes.includes('album')) {
            return 'album';
        }
        return 'track';
    },
    starTypes: function() {
        return this.selectedTypes
            .filter(type_ => type_ != this.backboneType)
            ?.map(type_ => type_ + 's')
            ?.join(' and ');
    }
},
watch: {
    options: {
    deep: true,
    handler(o) {
        this.network.setOptions(o);
    }
    }
},
methods: {
    setData(n, e) {
    this.visData.nodes = Array.isArray(n) ? new DataSet(n) : n;
    this.visData.edges = Array.isArray(e) ? new DataSet(e) : e;
    this.network.setData(this.visData);
    },
    destroy() {
    this.network.destroy();
    },
    getNode(id) {
    return this.visData.nodes.get(id);
    },
    getEdge(id) {
    return this.visData.edges.get(id);
    },
    setOptions(options) {
    this.network.setOptions(options);
    },
    on(event, callback) {
    this.network.on(event, callback);
    },
    off(event, callback) {
    this.network.off(event, callback);
    },
    once(event, callback) {
    this.network.once(event, callback);
    },
    canvasToDom(p) {
    return this.network.canvasToDOM(p);
    },
    domToCanvas(p) {
    return this.network.DOMtoCanvas(p);
    },
    redraw() {
    this.network.redraw();
    },
    setSize(w, h) {
    this.network.setSize(w, h);
    },
    cluster(options) {
    this.network.cluster(options);
    },
    clusterByConnection(nodeId, options) {
    this.network.clusterByConnection(nodeId, options);
    },
    clusterByHubsize(hubsize, options) {
    this.network.clusterByHubsize(hubsize, options);
    },
    clusterOutliers(options) {
    this.network.clusterOutliers(options);
    },
    findNode(id) {
    return this.network.findNode(id);
    },
    getClusteredEdges(baseEdgeId) {
    return this.network.clustering.getClusteredEdges(baseEdgeId);
    },
    getBaseEdge(clusteredEdgeId) {
    return this.network.clustering.getBaseEdge(clusteredEdgeId);
    },
    getBaseEdges(clusteredEdgeId) {
    return this.network.clustering.getBaseEdges(clusteredEdgeId);
    },
    updateEdge(startEdgeId, options) {
    this.network.clustering.updateEdge(startEdgeId, options);
    },
    updateClusteredNode(clusteredNodeId, options) {
    this.network.clustering.updateClusteredNode(clusteredNodeId, options);
    },
    isCluster(nodeId) {
    return this.network.isCluster(nodeId);
    },
    getNodesInCluster(clusterNodeId) {
    return this.network.getNodesInCluster(clusterNodeId);
    },
    openCluster(nodeId, options) {
    this.network.openCluster(nodeId, options);
    },
    getSeed() {
    return this.network.getSeed();
    },
    enableEditMode() {
    this.network.enableEditMode();
    },
    disableEditMode() {
    this.network.disableEditMode();
    },
    addNodeMode() {
    this.network.addNodeMode();
    },
    addNodes(newNodes) {
    newNodes.forEach( newNode => {if (!this.visData.nodes.getIds().includes(newNode.id)) {this.visData.nodes.add(newNode)}});
    },
    overrideNode(node) {
    this.visData.nodes.update(node);
    },
    addEdges(newEdges) {
    newEdges.forEach( newEdge => {if (!this.visData.edges.map(edge => edge.unordered_id).includes(newEdge.unordered_id)) {this.visData.edges.add(newEdge)}});
    },
    overrideEdge(edge) {
    this.visData.edges.update(edge);
    },
    getInvolvedBackboneEdges(nodeId) {
    const involvedEdges = [];
    this.visData.edges.forEach( edge => {
        if (
            (edge.from === nodeId)
            || (edge.to === nodeId)
            && (
                (this.getNode(edge.from)?.is_backbone)
                || (this.getNode(edge.to)?.is_backbone)
            )
        ) {
            involvedEdges.push(edge);
        }
    })
    return involvedEdges;
    },
    removeNode(node) {
    this.visData.nodes.remove(node);
    },
    editNode() {
    this.network.editNode();
    },
    addEdgeMode() {
    this.network.addEdgeMode();
    },
    editEdgeMode() {
    this.network.editEdgeMode();
    },
    deleteSelected() {
    this.network.deleteSelected();
    },
    getPositions(nodeIds) {
    return this.network.getPositions(nodeIds);
    },
    storePositions() {
    this.network.storePositions();
    },
    moveNode(nodeId, x, y) {
    this.network.moveNode(nodeId, x, y);
    },
    getBoundingBox(nodeId) {
    return this.network.getBoundingBox(nodeId);
    },
    getConnectedNodes(nodeId, direction) {
    return this.network.getConnectedNodes(nodeId, direction);
    },
    getConnectedEdges(nodeId) {
    return this.network.getConnectedEdges(nodeId);
    },
    startSimulation() {
    this.network.startSimulation();
    },
    stopSimulation() {
    this.network.stopSimulation();
    },
    stabilize(iterations) {
    this.network.stabilize(iterations);
    },
    getSelection() {
    return this.network.getSelection();
    },
    getSelectedNodes() {
    return this.network.getSelectedNodes();
    },
    getSelectedEdges() {
    return this.network.getSelectedEdges();
    },
    getNodeAt(p) {
    return this.network.getNodeAt(p);
    },
    getEdgeAt(p) {
    return this.network.getEdgeAt(p);
    },
    selectNodes(nodeIds, highlightEdges) {
    this.network.selectNodes(nodeIds, highlightEdges);
    },
    selectEdges(edgeIds) {
    this.network.selectEdges(edgeIds);
    },
    setSelection(selection, options) {
    this.network.setSelection(selection, options);
    },
    unselectAll() {
    this.network.unselectAll();
    },
    getScale() {
    return this.network.getScale();
    },
    getViewPosition() {
    return this.network.getViewPosition();
    },
    fit(options) {
    this.network.fit(options);
    },
    focus(nodeId, options) {
    this.network.focus(nodeId, options);
    },
    moveTo(options) {
    this.network.moveTo(options);
    },
    releaseNode() {
    this.network.releaseNode();
    },
    getOptionsFromConfigurator() {
    return this.network.getOptionsFromConfigurator();
    }
},
created() {
    // This should be a Vue data property, but Vue reactivity kinda bugs Vis.
    // See here for more: https://github.com/almende/vis/issues/2524
    this.network = null;
},
mounted() {
    const container = this.$refs.visualization;
    this.visData.nodes = mountVisData(this, "nodes");
    this.visData.edges = mountVisData(this, "edges");
    this.length = this.visData.nodes.length;
    this.network = new Network(container, this.visData, this.options);

    this.events.forEach(eventName => {
    this.network.on(eventName, props => {
        this.$emit(translateEvent(eventName), props)
    })
    });
},
beforeMount() {
    this.network?.destroy();
}
};
</script>