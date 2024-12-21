<template>
    <div class='query-input-container'>
        <input class='search-input' @keyup.enter="$emit('inputEnter')"
        v-model='searchValue' @input="$emit('update:modelValue', $event.target.value)"
        type='text' :placeholder='placeholder' autofocus ref='input'>
        <span v-show="!isMobile" class="indicator"> with types </span>
        <multiselect 
        v-show="!isMobile"
        id="type-selector" 
        v-model="selectedTypes" 
        :options="allTypes" 
        :multiple="true" 
        :allowEmpty="false"
        :closeOnSelect="false"
        placeholder="Select types"
        group-values="types" group-label="grp" track-by="name" label="name" :group-select="true" :hideSelected="true"
        />
    </div>

  </template>
  
  <script>
  /**
   * A user control that renders input string with read-only prefix/suffix
   */
   import Multiselect from 'vue-multiselect'


  export default {
    props: ['placeholder', 'modelValue', 'isMobile'],
    watch: {
      modelValue(newValue) {
        console.log('emitted');
        this.$refs.input.value = newValue;
        return newValue
      }
    },
    data: () => ({
      searchValue: '',
      allTypes: [{
        grp: "All",
        types: [
            {name:'album'},{ name:'artist'}, {name: 'track'}
        ],
      }],
      selectedTypes: [
            {name:'album'},{ name:'artist'}, {name: 'track'}
        ],
    }),
    components: {
      Multiselect,
    },
    computed: {
    },
    methods: {
      focus() {
        this.$refs.input.focus();
      },
    },
    mounted() {}
  }
  </script>
 
 <style src="vue-multiselect/dist/vue-multiselect.min.css"></style>
  <style lang="stylus">
  @import('../vars.styl');
  

  .query-input-container {
    position: relative;
    display: flex;

    span {
      display: inline;
    }
  
    input {
      border: none;
      font-family: 'Avenir', Helvetica, Arial, sans-serif;
      padding: 0;
      color: highlight-color
      height: 100%;
      font-size: 16px;
      font-style: oblique;
      &:focus {
        outline: none;
      }
    }
  }
  
  .indicator {
    padding-right: 30px;
    padding-left: 30px;
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    font-style: oblique;
  }

  .multiselect {
    .multiselect__tag {
      display: inline-flex;
      vertical-align: center;
      background-color: rgba(#ff673d, .7);
    }
    .multiselect__tag-icon::after {
      color: rgba(highlight-color, 1);
    }
    .multiselect__tag-icon:focus::after,
    .multiselect__tag-icon:hover::after {
       color: white;
    }
  }

  </style>