window.onload = function(){print();};

/*function imprime(){

	var x=document.getElementById('imprime').innerHTML;

	var head = "<head><title>Reporte</title>"+
				"<link rel='stylesheet' type='text/css' href='print.css'>"+
				"</head>"
	var body = "<body>"+x+"</body>";
	var source = '<html>'+head+body+'</html>';
	var printWindow = window.open('', '', 'height=400,width=800');

	printWindow.document.write(source);
	printWindow.print();

}
*/

descargar = function(){
	html2canvas(document.body,{onrendered: function(canvas){
		alert('Descargando...');
		var img = canvas.toDataURL("image/png");
		var doc = new jsPDF('0', 'pt', 'letter');
		var width = canvas.width;
		var height = canvas.clientHeight;
		doc.addImage(img, 'PNG', 20, 20);
		doc.save('text.pdf');
	}});
}