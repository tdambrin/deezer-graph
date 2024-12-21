# Deezer Graph Search: Connect artists, albums and tracks

<a href="LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-brightgreen.svg?" alt="Software License" />
</a>
<a href="Vue">
    <img src="https://img.shields.io/badge/vue-3.2.13-green.svg" alt="Vue JS version" />
</a>

---

Visualize music as connections. Paired with [Deezer Graph API](https://github.com/tdambrin/deezer-graph)

![demo](./doc/assets/Deezer%20Graph%20Demo%20(Saturn%20SZA).gif)

## How it works

<div>
    <h3>Enter search keywords to get a graph</h3>
    <h4><i>Graph properties</i></h3>
    <p>
        By default, The graph structure is <b>a backbone of artists</b>
        <span v-show="this.starTypes"> with <b>stars of tracks and abums</b> from a backbone node.</span>
    </p>
    <p>A node size is proportional to its popularity.</p>
    <p>Each color group represents star nodes related to the same backbone node.</p>
    <h3><i>Interactions</i></h3>
    <p>
        <i v-show="!isMobile">Hover - </i>
        Play track preview
    </p>
    <p><i>Double Click - </i>Expand graph around outside node</p>
    <p><i>Shift Click - </i>Open Deezer</p>
    <p><i>Alt/Option Click - </i>Delete node and its successors</p>
</div>

## Credits

- [vs](https://github.com/anvaka/vs)
- [vue-vis-network](https://github.com/r3code/vue-vis-network)

---

## Policies
Feedbacks and contributions are greatly appreciated.

For questions, please feel free to reach out [by email](mailto:thomas.dambrin@gmail.com?subject=[GitHub]%20Deezer%20Graph%20UI).