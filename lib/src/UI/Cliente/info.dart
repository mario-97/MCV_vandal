class Grafico {
  final int kcal;
  final int dias;

  Grafico(this.kcal, this.dias);
}

class InfoEjercicio {
  String idEjercicio;
  String nombre;
  String kcal;
  String tiempo;
  String idCliente;
  String estado;
  String operacion;
  String idInfo;
  String totalkcal;
  String totaltiempo;
  List<Grafico> data;

  InfoEjercicio(
      this.idEjercicio,
      this.nombre,
      this.kcal,
      this.tiempo,
      this.idCliente,
      this.estado,
      this.operacion,
      this.idInfo,
      this.totalkcal,
      this.totaltiempo,
      this.data);
}
