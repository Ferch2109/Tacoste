window.onload = function(){
	var w=window.open(' ','popimpr');
	var doc = document.getElementById('print');
	alert(doc.innerHTML);
	w.document.write(doc.innerHTML);
	w.print();
	w.close();
};


descargar = function(){
	html2canvas(document.body,{onrendered: function(canvas){
		alert('Descargando...');
		var img = canvas.toDataURL("image/png");
		var doc = new jsPDF('0', 'pt', 'letter');
		var width = canvas.width;
		var height = canvas.clientHeight;
		doc.addImage(img, 'PNG', 20, 20);
		doc.save('Reporte.pdf');
	}});
}