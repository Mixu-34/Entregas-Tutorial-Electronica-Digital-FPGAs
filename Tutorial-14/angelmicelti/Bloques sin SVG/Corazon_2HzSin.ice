{
  "version": "1.2",
  "package": {
    "name": "2 Hz",
    "version": "0.1",
    "description": "Bombear 2 bits por segundo",
    "author": "Juan Gonzalez-Gomez (obijuan)",
    "image": ""
  },
  "design": {
    "board": "icezum",
    "graph": {
      "blocks": [
        {
          "id": "70887b0b-826c-4150-a873-605b77da8272",
          "type": "basic.output",
          "data": {
            "name": "",
            "pins": [
              {
                "index": "0",
                "name": "LED0",
                "value": "95"
              }
            ],
            "virtual": true
          },
          "position": {
            "x": 560,
            "y": 128
          }
        },
        {
          "id": "4656865c-bcf1-4668-8e13-9221e32222d3",
          "type": "basic.input",
          "data": {
            "name": "",
            "pins": [
              {
                "index": "0",
                "name": "",
                "value": "0"
              }
            ],
            "virtual": true,
            "clock": true
          },
          "position": {
            "x": -304,
            "y": 128
          }
        },
        {
          "id": "7e864797-b165-408f-a9ce-2e71dc63f8b8",
          "type": "basic.code",
          "data": {
            "code": "\n//-- Constante para dividir y obtener una frecuencia de 2Hz\nlocalparam M = 6000000;\n\n//-- Calcular el numero de bits para almacenar M\nlocalparam N = $clog2(M);\n\n//-- Registro del divisor\nreg [N-1:0] divcounter;\n\n//-- Temporal clock\nreg clk_t = 0;\n\n//-- Se usa un contador modulo M/2 para luego\n//-- pasarlo por un biestable T y dividir la frecuencia\n//-- entre 2, para que el ciclo de trabajo sea del 50%\nalways @(posedge clk)\n    if (divcounter == M/2) begin\n      clk_t <= 1;\n      divcounter = 0;\n    end \n    else begin\n      divcounter <=  divcounter + 1;\n      clk_t = 0;\n    end \n  \nreg clk_o = 0;  \n    \n//-- Biestable T para obtener ciclo de trabajo del 50%\nalways @(posedge clk)\n  if (clk_t)\n    clk_o <= ~clk_o;\n",
            "params": [],
            "ports": {
              "in": [
                {
                  "name": "clk"
                }
              ],
              "out": [
                {
                  "name": "clk_o"
                }
              ]
            }
          },
          "position": {
            "x": -104,
            "y": -104
          },
          "size": {
            "width": 528,
            "height": 528
          }
        }
      ],
      "wires": [
        {
          "source": {
            "block": "7e864797-b165-408f-a9ce-2e71dc63f8b8",
            "port": "clk_o"
          },
          "target": {
            "block": "70887b0b-826c-4150-a873-605b77da8272",
            "port": "in"
          }
        },
        {
          "source": {
            "block": "4656865c-bcf1-4668-8e13-9221e32222d3",
            "port": "out"
          },
          "target": {
            "block": "7e864797-b165-408f-a9ce-2e71dc63f8b8",
            "port": "clk"
          }
        }
      ]
    }
  },
  "dependencies": {}
}