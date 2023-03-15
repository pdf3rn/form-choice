import Choices from "choices";
import {Controller} from "@hotwired/stimulus"

export default class ChoicesField extends Controller {
    // choices: Choices

    connect() {
        this.field = this.element.querySelector(".choices-field");
        if (!this.field) return;
        let options = {}
        options = {...options, ...this.defaultOptions};
        this.choice = new Choices(this.field, options);
        this.reload = this.debounce(this.reload, 200).bind(this);
        this.field.addEventListener('form-choice:refresh', this.reload.bind(this));
    }

    reload() {
        if (this.field.getAttribute("fetch")) {
            let placeholder = this.choice._placeholderValue;
            let path = this.field.getAttribute("fetch");
            let params = this.field.getAttribute("params");
            let url = `${path}.json?${params ? params : ''}`
            this.choice.setChoices(function () {
                return fetch(url).then(function (response) {
                    return response.json();
                }).then(function (data) {
                    return data.map((row) => {
                        return {value: row.id, label: row.name};
                    });
                });
            }, 'value', 'label', true);
            this.choice._selectPlaceholderChoice({value: "", label: placeholder, placeholder: true});
        }
    }

    disconnect() {
        this.choice.destroy();
        this.choice = undefined;
    }

    get defaultOptions() {
        return {
            allowHTML: false,
            searchPlaceholderValue: 'Buscar',
            placeholder: true,
            placeholderValue: 'Seleccione valor',
            maxItemCount: 5,
            removeItemButton: true,
            loadingText: 'Cargando...',
            noResultsText: 'No se han encontrado resultados',
            noChoicesText: 'No hay opciones para elegir',
            itemSelectText: 'Pulsar para seleccionar',
            uniqueItemText: 'Sólo se pueden añadir valores únicos',
            customAddItemText: 'Sólo pueden añadirse valores que cumplan determinadas condiciones',
            addItemText: (value) => `Pulsa Intro para añadir <b>"${value}"</b>.`,
            maxItemText: (maxItemCount) => `Sólo se pueden añadir ${maxItemCount} valores.`,
        }
    }

    debounce(func, wait, immediate = false) {
        let timeout;
        return function () {
            const context = this;
            const args = arguments;
            const later = function () {
                timeout = null;
                if (!immediate) func.apply(context, args);
            };
            const callNow = immediate && !timeout;
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
            if (callNow) func.apply(context, args);
        };
    }
}
