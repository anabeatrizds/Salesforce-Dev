import { LightningElement } from 'lwc';
export default class App extends LightningElement {
    ready = false;
    connectedCallback() {
        setTimeout(() => {
            this.ready = true;
        }, 3000);
    }
}