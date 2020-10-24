// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import { Socket } from "phoenix"
import NProgress from "nprogress"
import { LiveSocket } from "phoenix_live_view"

const csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

const hooks = {
  search: {
    mounted() {
      const labelElem = this.el
      const inputElem = this.el.children[0]

      const neededClass = "search-form__label--field-in-focus"

      const inputValue = () => inputElem.value

      const isInputEmpty = () => (inputValue() === "" || inputValue() == null)

      const handleInput = () => isInputEmpty()
        ? labelElem.classList.remove(neededClass)
        : labelElem.classList.add(neededClass)

      inputElem.onkeydown = inputElem.onkeyup = inputElem.onkeypress = handleInput
    }
  },

  drag: {
    mounted() {
      this.el.setAttribute("draggable", "true");

      this.el.ondragstart = event => {
        console.log("START: ", this.el);

        event.dataTransfer.effectAllowed = "move";
        event.dataTransfer.setData('text/plain', this.el.id)
      }

      this.el.ondragover = event => {
        event.preventDefault()

        this.dropMargins()

        if (this.el.clientHeight / 2 - event.layerY > 0) {
          this.el.style.marginTop = '30px'
        } else {
          this.el.style.marginBottom = '30px'
        }
      }

      this.el.ondragend = () => this.dropMargins()
    },

    dropMargins() {
      Array.from(document.getElementsByClassName("bookmark"))
        .forEach(element => element.style.margin = "0 0 0 0");
    }
  },

  drop: {
    area() { return this.el.id || "droparea" },

    mounted() {
      console.log(this.el);

      this.el.ondrop = event => {
        console.log('FINISH');

        event.preventDefault();
        event.stopPropagation();

        const data = event.dataTransfer.getData('text/plain');

        console.log(data);

        this.pushEvent("drop", { area: this.area(), id: data })

      }
    }
  }
}

const liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: hooks,
})

// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket
