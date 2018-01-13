window.onload = function(){
	var head = "<head><title>Reporte</title>"+
				"<link rel='stylesheet' type='text/css' href='reporte.css'>"+
				"<!--<<script type='conic-gradient.js'></script>--></head>"
	var body = "<body>"+document.getElementsByTagName('body')[0].innerHTML+"</body>";
	var source = '<html>'+head+body+'</html>';
	var printWindow = window.open('', '', 'height=400,width=800');
	
	printWindow.document.write('<html>');
	printWindow.document.write(head);
	printWindow.document.write(body);
	printWindow.document.write('</html>');
	printWindow.document.close();
	printWindow.print();
}


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