window.onload = function(){
	var head = "<head><title>Reporte</title>"+
				"<link rel='stylesheet' type='text/css' href='reporte.css'>"+
				"<!--<<script type='conic-gradient.js'></script>--></head>"
	var body = "<body>"+document.getElementsByTagName('body')[0].innerHTML+"</body>";
	var source = '<html>'+head+body+'</html>';
/*	var printWindow = window.open('', '', 'height=400,width=800');
	
	printWindow.document.write('<html>');
	printWindow.document.write(head);
	printWindow.document.write(body);
	printWindow.document.write('</html>');
	printWindow.document.close();
	printWindow.print();
*/


html2canvas(document.body,{onrendered: function(canvas){
		var img = canvas.toDataURL("image/png");
		var doc = new jsPDF();
		var width = canvas.width;
		var height = canvas.clientHeight;
		doc.addImage(img, 'PNG', 10, 10);
		doc.save('text.pdf');
	}});
}