function addCard() {
    var firebase = "https://sienapa-734e9-default-rtdb.firebaseio.com/data/pozos.json";
    var datos_pozo = new EventSource(firebase);
    datos_pozo.addEventListener('put', function (e) {
      var json = JSON.parse(e.data);
      console.log(json);
      if (json.path == "/") {
        dbody = document.getElementById("container-flip-card-body");
        for (var key in json.data) {
          var div = document.createElement("div");
          var h5_f = document.createElement("h5");
          var p_1 = document.createElement("input");
          var p_2 = document.createElement("p");
          var div_button = document.createElement("div");
          var h5_b = document.createElement("h5");
          var p_3 = document.createElement("p");
          var p_4 = document.createElement("p");
          var p_5 = document.createElement("p");
          var p_6 = document.createElement("p");
          var button = document.createElement("div");
  
          //Agregar las clases de cada elemento
          div.classList.add("flip-card", key);
          p_1.id = key; 
          p_1.readOnly = true;
          p_2.disabled = true;
          h5_f.classList.add("card-title");
          p_1.classList.add("card-text", "estado");
          p_2.classList.add("card-text", "electricidad");
          div_button.classList.add("d-grid", "gap-2");
          h5_b.classList.add("card-title");
          p_3.classList.add("card-text");
          p_4.classList.add("card-text");
          p_5.classList.add("card-text");
          p_6.classList.add("card-text");
  
          //Insertar valores por medio de innerHTML
          //var str = json.data[key].nombre;
          //var title_name = str.split(' ').join('');
  
          h5_f.innerHTML = json.data[key].nombre;
          //var estado = json.data[key].estado_pozo.estado === 1 ? "Encendido" : "Apagado";
          p_1.innerHTML = json.data[key].estado_pozo.estado;
          //var electricidad = json.data[key].estado_pozo.electricidad;
          p_2.innerHTML = "<b>Electricidad:</b> " + json.data[key].estado_pozo.electricidad;
          div_button.innerHTML = `<button class="btn btn-success" id="${key}" type="button" onclick="powerClick(this.id)"><i class="bi bi-power"></i></button>
                                        <button class="btn btn-info" id="${key}" onclick="flipCard(this.id)">Mas información</button>`;
          h5_b.innerHTML = json.data[key].nombre;
          p_3.innerHTML = "<b>Convenio:</b> " + json.data[key].convenio;
          p_4.innerHTML = "<b>Concesión:</b> " + json.data[key].concesion;
          p_5.innerHTML = "<b>Ubicación:</b> " + json.data[key].ubicacion;
          p_6.innerHTML = "<b>Información extra:</b> " + json.data[key].informacion;
          button.innerHTML = `<button class="btn btn-dark" id="${key}" onclick="flipCard(this.id)">Regresar</button>`;
  
  
          // Unir todo
          div.innerHTML = `
          <div class="flip-card-inner">
            <div class="flip-card-front">
              <div class="card" style="width: 18rem;">
                <div class="card-body">
                  <img src="https://telegra.ph/file/c19f88650a45e2c393ceb.png" class="gota">
                  ${h5_f.outerHTML}
                  <p><b>Estado:</b></p>
                  ${p_1.outerHTML}
                  ${p_2.outerHTML}
                  ${div_button.outerHTML}
                </div>
              </div>
            </div>
            <div class="flip-card-back">
              <div class="card" style="width: 18rem;">
                <div class="card-body">
                  <img src="https://telegra.ph/file/c19f88650a45e2c393ceb.png" class="gota">
                  ${h5_b.outerHTML}
                  ${p_3.outerHTML}
                  ${p_4.outerHTML}
                  ${p_5.outerHTML}
                  ${p_6.outerHTML}
                  ${button.outerHTML}
                </div>
              </div>
            </div>
          </div>
        `;
          //Agregar el contenido al HTML
          dbody.appendChild(div);
  
          document.getElementById(key).value = json.data[key].estado_pozo.estado;
        }
      } else {
        s = json.path.split("/");
        console.log(s[1]);
        console.log(json.data);
        document.getElementById(s[1]).value = json.data;
      }
    });
  };
  
  