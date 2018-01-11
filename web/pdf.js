window.onload = function(){
	var head = "<head><title>Reporte</title>"+
				"<link rel='stylesheet' type='text/css' href='reporte.css'>"+
				"<!--<<script type='conic-gradient.js'></script>--></head>"
	var body = "<body>"+document.getElementsByTagName('body')[0].innerHTML+"</body>";

	var printWindow = window.open('', '', 'height=400,width=800');
	
	printWindow.document.write('<html>');
	printWindow.document.write(head);
	printWindow.document.write(body);
	printWindow.document.write('</html>');
	printWindow.document.close();
	printWindow.print();
}