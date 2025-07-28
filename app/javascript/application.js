// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Start StimulusJS
import { Application } from "@hotwired/stimulus"

const application = Application.start();

// Import and register all TailwindCSS Components or just the ones you need
import { Alert} from "tailwindcss-stimulus-components"
application.register('alert', Alert)
