document.addEventListener('turbolinks:load', function() {
    // handler for change event
    // dynamically loads avatar preview
    $('.avatar-preview').on('change', function(event) {
      // grab file of descendat or higher
      var files = event.target.files;
      var image = files[0]
      // read asynchronously
      var reader = new FileReader();
      // register handler for onload event
      reader.onload = function(file) {
        // create new Image from received file
        var img = new Image();
        img.src = file.target.result;
        // render in it
        console.log(file);
        $('#target').html(img);
      }
      // read from generated file
      reader.readAsDataURL(image);
      console.log(files);
    });
  });