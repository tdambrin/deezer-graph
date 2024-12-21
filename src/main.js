import { createApp } from 'vue'
import App from './App.vue'
import VueCookies from 'vue-cookies'


const app = createApp(App)
app.use(VueCookies, {expires: '1h'})
app.mount('#app')
console.log(app.$primevue)