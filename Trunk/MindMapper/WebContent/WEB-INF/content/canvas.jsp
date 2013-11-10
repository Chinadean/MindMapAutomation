<!doctype html>
<!-- DEBUG -->
<!-- disable offline caching in debug mode -->
<html>
<!-- /DEBUG -->
<!-- PRODUCTION
<html manifest="cache.manifest">
/PRODUCTION -->
<head>
<meta charset="utf-8">
<title>mindmaps</title>
<link rel="icon" type="image/png" href="img/favicon.png" />
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/app.css">
<link rel="stylesheet" href="css/Aristo/jquery-ui-1.8.7.custom.css" />
<link rel="stylesheet" href="css/minicolors/jquery.miniColors.css">

<script id="template-float-panel" type="text/x-jquery-tmpl">
<div class="ui-widget ui-dialog ui-corner-all ui-widget-content float-panel no-select">
	<div class="ui-dialog-titlebar ui-widget-header ui-helper-clearfix">
		<span class="ui-dialog-title">${title}</span>
		<a class="ui-dialog-titlebar-close ui-corner-all" href="#" role="button">
			<span class="ui-icon"></span>
		</a>
	</div>
	<div class="ui-dialog-content ui-widget-content">
	</div>
</div>
</script>

<script id="template-notification" type="text/x-jquery-tmpl">
<div class="notification">
	{{if closeButton}}
	<a href="#" class="close-button">x</a>
	{{/if}}
	{{if title}}
	<h1 class="title">{{html title}}</h1>
	{{/if}}
	<div class="content">{{html content}}</div>
</div>
</script>

<script id="template-open-table-item" type="text/x-jquery-tmpl">
<tr>
	<td><a class="title" href="#">${title}</a></td>
	<td>${$item.format(dates.modified)}</td>
	<td><a class="delete" href="#">delete</a></td>
</tr>
</script>

<script id="template-open" type="text/x-jquery-tmpl">
<div id="open-dialog" class="file-dialog" title="Open mind map">
	<h1>Local Storage</h1>
	<p>This is a list of all mind maps that are saved in your browser's local storage. Click on the title of a map to open it.</p>
	<table class="localstorage-filelist">
		<thead>
			<tr>
				<th class="title">Title</th>
				<th class="modified">Last Modified</th>
				<th class="delete"></th>
			</tr>
		</thead>
		<tbody class="document-list"></tbody>
	</table>
	<div class="seperator"></div>
	<h1>From file</h1>
	<p>Choose a mind map from your computer's hard drive.</p>
	<div class="file-chooser">
		<input type="file" />
	</div>
	<div class="seperator"></div>
	<h1>Database</h1>
	<p>This is a list of all mind maps that are saved in your database. Click on the title of a map to open it.</p>
	<table class="database-filelist">
		<thead>
			<tr>
				<th class="title">Title</th>
				<th class="modified">Last Modified</th>
				<th class="delete"></th>
			</tr>
		</thead>
		<tbody class="database-list"></tbody>
	</table>
</div>
</script>

<script id="template-save" type="text/x-jquery-tmpl">
<div id="save-dialog" class="file-dialog" title="Save mind map">
	<h1>Local Storage</h1>
	<p>You can save your mind map in your browser's local storage. Be aware that this is still experimental: the space is limited and there is no guarantee that the browser will keep this document forever.</p>
	<button id="button-save-localstorage">Save</button>
	<div class="seperator"></div>
	<h1>To file</h1>
	<p>Save the mind map as a file on your computer.</p>
	<div id="button-save-hdd">Save</div>
	<div class="seperator"></div>
	<h1>Database</h1>
	<p>Save to your database using the settings you have setup in the db_actions.php file.</p>
	<div id="button-save-db">Save</div>
</div>
</script>

<script id="template-navigator" type="text/x-jquery-tmpl">
<div id="navigator">
	<div class="active">
		<div id="navi-content">
			<div id="navi-canvas-wrapper">
				<canvas id="navi-canvas"></canvas>
				<div id="navi-canvas-overlay"></div>
			</div>
			<div id="navi-controls">
				<span id="navi-zoom-level"></span>
				<div class="button-zoom" id="button-navi-zoom-out"></div>
				<div id="navi-slider"></div>
				<div class="button-zoom" id="button-navi-zoom-in"></div>
			</div>
		</div>
	</div>
	<div class="inactive">
	</div>
</div>
</script>


<script id="template-inspector" type="text/x-jquery-tmpl">
<div id="inspector">
	<div id="inspector-content">
		<table id="inspector-table">
			<tr>
				<td>Font size:</td>
				<td><div
						class="buttonset buttons-very-small buttons-less-padding">
						<button id="inspector-button-font-size-decrease">A-</button>
						<button id="inspector-button-font-size-increase">A+</button>
					</div></td>
			</tr>
			<tr>
				<td>Font style:</td>
				<td><div
						class="font-styles buttonset buttons-very-small buttons-less-padding">
						<input type="checkbox" id="inspector-checkbox-font-bold" />
						<label
						for="inspector-checkbox-font-bold" id="inspector-label-font-bold">B</label>

						<input type="checkbox" id="inspector-checkbox-font-italic" />
						<label
						for="inspector-checkbox-font-italic" id="inspector-label-font-italic">I</label>

						<input
						type="checkbox" id="inspector-checkbox-font-underline" />
						<label
						for="inspector-checkbox-font-underline" id="inspector-label-font-underline">U</label>

						<input
						type="checkbox" id="inspector-checkbox-font-linethrough" />
						 <label
						for="inspector-checkbox-font-linethrough" id="inspector-label-font-linethrough">S</label>
					</div>
				</td>
			</tr>
			<tr>
				<td>Font color:</td>
				<td><input type="hidden" id="inspector-font-color-picker"
					class="colorpicker" /></td>
			</tr>
			<tr>
				<td>Branch color:</td>
				<td><input type="hidden" id="inspector-branch-color-picker"
					class="colorpicker" /></td>
			</tr>
		</table>
		<!--<button id="inspector-button-apply-all" class="buttons-small">Apply
			styles to children...</button>-->
	</div>
</div>
</script>

<script id="template-export-map" type="text/x-jquery-tmpl">
<div id="export-map-dialog" title="Export mind map">
	<h2 class='image-description'>To download the map right-click the
		image and select "Save Image As"</h2>
	<div id="export-preview"></div>
</div>
</script>

</head>
<body>
<form action="map/test-process" class="UserInputs" method="post">    
  Map Id    <input type="text" name="mapId" style="width: 50px;"/> 
  Input Text <input type="text" name="inputText" style="width: 1100px;" />
   <button id="btnFrmPost1" >Post</button>
</form>
	<div id="print-area">
		<p class="print-placeholder">Please use the print option from the
			mind map menu</p>
	</div>
	<!-- DEBUG -->
		<!-- <div id="debug-warning">Running in DEBUG mode.</div>  -->
	<!-- /DEBUG -->
	<div id="container">
		<div id="topbar">
			<div id="toolbar">
				<div id="logo" class="logo-bg">
					<span>MindMapAutomation</span>
				</div>

				<div class="buttons">
					<span class="buttons-left"> </span> <span class="buttons-right">
					</span>
				</div>

			</div>
		</div>
		<div id="canvas-container">
			<div id="drawing-area"></div>
		</div>
		<div id="bottombar">
			<div id="about">
				
			</div>
			<div id="statusbar">
				<div
					class="buttons buttons-right buttons-small buttons-less-padding"></div>
			</div>
		</div>
	</div>
	<script src="sys_js/jquery-1.10.2.min.js"></script>
	
	<!-- DEBUG -->
	<!-- set debug flag for all scripts. Will be removed in production -->
	<script type="text/javascript">
		var mindmaps = mindmaps || {};
		mindmaps.DEBUG = false;
	</script>
	<!-- /DEBUG -->

	<!-- JS:LIB:BEGIN -->
	<script src="js/libs/jquery-ui-1.8.11.custom.min.js"></script>
	<script src="js/libs/dragscrollable.js"></script>
	<script src="js/libs/jquery.hotkeys.js"></script>
	<script src="js/libs/jquery.mousewheel.js"></script>
	<script src="js/libs/jquery.minicolors.js"></script>
	<script src="js/libs/jquery.tmpl.js"></script>
	<script src="js/libs/swfobject.js"></script>
	<script src="js/libs/downloadify.min.js"></script>
	<script src="js/libs/events.js"></script>

	<script src="js/MindMaps.js"></script>
	<script src="js/Command.js"></script>
	<script src="js/CommandRegistry.js"></script>
	<script src="js/Action.js"></script>
	<script src="js/Util.js"></script>
	<script src="js/Point.js"></script>
	<script src="js/Document.js"></script>
	<script src="js/MindMap.js"></script>
	<script src="js/Node.js"></script>
	<script src="js/NodeMap.js"></script>
	<script src="js/UndoManager.js"></script>
	<script src="js/UndoController.js"></script>
	<script src="js/ClipboardController.js"></script>
	<script src="js/ZoomController.js"></script>
	<script src="js/ShortcutController.js"></script>
	<script src="js/HelpController.js"></script>
	<script src="js/FloatPanel.js"></script>
	<script src="js/Navigator.js"></script>
	<script src="js/Inspector.js"></script>
	<script src="js/ToolBar.js"></script>
	<script src="js/StatusBar.js"></script>
	<script src="js/CanvasDrawingTools.js"></script>
	<script src="js/CanvasView.js"></script>
	<script src="js/CanvasPresenter.js"></script>
	<script src="js/ApplicationController.js"></script>
	<script src="js/MindMapModel.js"></script>
	<script src="js/NewDocument.js"></script>
	<script src="js/OpenDocument.js"></script>
	<script src="js/SaveDocument.js"></script>
	<script src="js/MainViewController.js"></script>
	<script src="js/Storage.js"></script>
	<script src="js/Event.js"></script>
	<script src="js/Notification.js"></script>
	<script src="js/StaticCanvas.js"></script>
	<script src="js/PrintController.js"></script>
	<script src="js/ExportMap.js"></script>
	<!-- JS:LIB:END -->

	<!-- PRODUCTION
<script type="text/javascript">
	var _gaq = _gaq || [];
	_gaq.push([ '_setAccount', 'UA-23624804-1' ]);
	_gaq.push([ '_trackPageview' ]);
	(function() {
		var ga = document.createElement('script');
		ga.type = 'text/javascript';
		ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl'
				: 'http://www')
				+ '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0];
		s.parentNode.insertBefore(ga, s);
	})();
</script>
/PRODUCTION -->
<script type="text/javascript">
 $(function() {
$.ajax(
			{
				url : 'map/test-process',
				type : 'post',			
				dataType : 'json',
				success : function(data)
				{
					var n = data.mindmap.replace("\\","");
					var doc=mindmaps.Document.fromJSON(n);
					mindmapsModelGloble.setDocument(doc);				
				}
			});
			
		     $("form.UserInputs").submit(function (event) {
		    	 
		            /* stop form from submitting normally */
		            event.preventDefault();
		 
		            /* get some values from elements on the page: */
		            var $form = $(this);
		 
		            var url = $form.attr('action');
		            var data = $form.serialize()
		             //Here I call the ajax and post the data
		            $.ajax({
		                type: "POST",
		                dataType: "json",
		                url: url,
		                data: data,
		                success: function (data) {
		                	var n = data.mindmap.replace("\\","");
							var doc=mindmaps.Document.fromJSON(n);
							mindmapsModelGloble.setDocument(doc);	
		                },
		                error: function (xhr, status, error) {                   
		                }
		            });
		        });
		        return false;		    
}); 



		</script>
</body>
</html>