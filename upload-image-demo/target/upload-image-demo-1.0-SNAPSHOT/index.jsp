<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Firebase upload image</title>
  
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container"
      style="margin-top: 50px;
             width: 50%; height:auto; ">

<div>
    Upload Files<br />
    <input type="file" id="files" multiple /><br /><br />
    <button id="send">Upload</button>
    <p id="uploading"></p>
    <progress value="0" max="100" id="progress"></progress>
</div>
<img src="" alt="Upload image" id="myimage" width="500" height="600">
<a href="newupdatecheck.html">Another way</a>

<script src="https://www.gstatic.com/firebasejs/3.7.4/firebase.js ">
</script>
<script src=
                "https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js ">
</script>

<link type="text/css " rel="stylesheet " href=
        "https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.css " />

<script src=
                "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js ">
</script>

<script type="module">
    // Import the functions you need from the SDKs you need
    import { initializeApp } from "https://www.gstatic.com/firebasejs/9.6.7/firebase-app.js";
    import { getAnalytics } from "https://www.gstatic.com/firebasejs/9.6.7/firebase-analytics.js";
    // TODO: Add SDKs for Firebase products that you want to use
    // https://firebase.google.com/docs/web/setup#available-libraries

    // Your web app's Firebase configuration
    // For Firebase JS SDK v7.20.0 and later, measurementId is optional
    const firebaseConfig = {
        apiKey: "AIzaSyBQ3Qz0ySc-z6jr2nkcYfXTrfHo_SNjzFQ",
        authDomain: "upload-image-demo-hamen.firebaseapp.com",
        // projectId: "upload-image-demo-hamen",
        storageBucket: "upload-image-demo-hamen.appspot.com",
        // messagingSenderId: "358022406601",
        // appId: "1:358022406601:web:24df93d64bb43141b7c818",
        // measurementId: "G-PFV8CVM1W3"
    };

    // Initialize Firebase
    const app = initializeApp(firebaseConfig);
    const analytics = getAnalytics(app);

    firebase.initializeApp(firebaseConfig);
</script>

<script>
    var files = [];
    document.getElementById("files").addEventListener("change", function(e) {
        files = e.target.files;
        for (let i = 0; i < files.length; i++) {
            console.log(files[i]);
        }
    });

    document.getElementById("send").addEventListener("click", function() {
        //checks if files are selected
        if (files.length != 0) {
            //Loops through all the selected files
            for (let i = 0; i < files.length; i++) {
                //create a storage reference
                var storage = firebase.storage().ref(files[i].name);

                //upload file
                var upload = storage.put(files[i]);

                //update progress bar
                upload.on(
                    "state_changed",
                    function progress(snapshot) {
                        var percentage =
                            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
                        document.getElementById("progress").value = percentage;
                    },

                    function error() {
                        alert("error uploading file");
                    },

                    function complete() {
                        document.getElementById(
                            "uploading"
                        ).innerHTML += `${files[i].name} upoaded <br />`;
                    }
                );
            }
        } else {
            alert("No file chosen");
        }
    });

    function getFileUrl(filename) {
        //create a storage reference
        var storage = firebase.storage().ref(filename);

        //get file url
        storage
            .getDownloadURL()
            .then(function(url) {
                console.log("this is image"+url);
                $('#myimage').attr('src',url);
            })
            .catch(function(error) {
                console.log("error encountered");
            });
    }
</script>
</body>
</html>