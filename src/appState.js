import Progress from './Progress';
import {reactive} from 'vue';


const appState = reactive({
  hasGraph: false,
  progress: new Progress(),
  graph: null,
});


export function getAppState() {
  return appState;
}