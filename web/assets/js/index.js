import * as Turbo from "@hotwired/turbo"
import { Application } from "@hotwired/stimulus"

import HelloController from "./controllers/hello_controller"
import DevToolController from "./controllers/dev_tool_controller"

window.Stimulus = Application.start()

Stimulus.register("hello", HelloController)
Stimulus.register("dev-tool", DevToolController)
