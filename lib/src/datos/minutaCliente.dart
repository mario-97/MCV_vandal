class MinutaCliente {
  String id;
  String idCliente;
  String tipodieta;
  String rangoedad;
  String desayuno;
  String almuerzo;
  String cena;
  String merienda;
  String calorias;
  String dia;
  String operacion;

  MinutaCliente(this.id, this.idCliente, this.tipodieta, this.rangoedad, this.desayuno, this.almuerzo,
      this.cena, this.merienda, this.calorias,  this.dia, this.operacion);
}

class Grafico {
  final int calorias;
  final int dias;

  Grafico(this.calorias, this.dias);
}
