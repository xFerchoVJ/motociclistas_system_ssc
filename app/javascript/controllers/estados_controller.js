import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="estados"
export default class extends Controller {
  static targets = ["estados", "municipios"]; // Selects
  connect() {
    this.cargarEstados();
  }

  async cargarEstados() {
    const res = await fetch("/estados");
    const data = await res.json();
    this.estadosTarget.innerHTML = '<option value="">Selecciona un estado</option>'
    if(data){
      data.forEach(estado => {
        this.estadosTarget.innerHTML += `<option value="${estado}">${estado}</option>`;
      })
    }
  }

  async cargarMunicipios(event){
    const estado = event.target.value;
    const municipiosSelect = this.municipiosTarget;
    municipiosSelect.disabled = true;
    if(estado){
      const res = await fetch(`/municipios?estado=${estado}`);
      const municipios = await res.json();
      municipiosSelect.innerHTML = '<option value="">Selecciona un municipio</option';
      if(municipios){
        municipios.forEach(municipio => {
          municipiosSelect.innerHTML += `<option value="${municipio}">${municipio}</option>`;
        })
        municipiosSelect.disabled = false;
      }
    }else{
      municipiosSelect.innerHTML = '<option value="">Selecciona un municipio</option';
      municipiosSelect.disabled = true;
    }
  }
}
