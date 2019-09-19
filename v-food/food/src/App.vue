<template>
  <div id="app">
    <router-view v-on:isActive="isActive"/>
    <footer-component :active="active"></footer-component>
  </div>
</template>

<script>
import footerComponent from './components/footer.vue'
export default {
  name: 'App',
  data(){
    return {
      active:false
    }
  },
  methods:{
    isActive(active)
    {
      this.active = active;
    }
  },
  components:{footerComponent}
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  height: 100%;
}
</style>
