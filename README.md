<br />
<div align="center">
  <a href="https://sensifai.com">
    <img src="assets/images/png/logo_dark.png" alt="Logo" width="224" height="41">
  </a>
</div>

<h3 align="center">Sensifai Smart Gallery</h3>


### Introduction
Billions of users manually upload their captured videos and images to cloud storages such as Dropbox, Google Drive and Apple iCloud straight from their camera or phone. Their private pictures and video material are subsequently stored unprotected somewhere else on some remote computer, in many cases in another country with quite different legislation. Users depend on the tools from these service providers to browse their archives of often thousands and thousands of videos and photo's in search of some specific image or video of interest. The direct result of this is continuous exposure to cyber threats like extortion and an intrinsic loss of privacy towards the service providers. There is a perfectly valid user-centric approach possible in dealing with such confidential materials, which is to encrypt everything before uploading anything to the internet. At that point the user may be a lot more safe, but from now on would have a hard time locating any specific videos or images in their often very large collection. What if smart algorithms could describe the pictures for you, recognise who is in it and you can store this information and use it to conveniently search and share? This project develops an open source smart-gallery app which uses machine learning to recognize and tag all visual material automatically - and on the device itself. After that, the user can do what she or he wants with the additional information and the original source material. They can save them to local storage, using the tags for easy search and navigation. Or offload the content to the internet in encrypted form, and use the descriptions and tags to navigate this remote content. Either option makes images and videos searchable while fully preserving user privacy.

This project was funded through the NGI0 Discovery Fund, a fund established by NLnet with financial support from the European Commission's Next Generation Internet programme, under the aegis of DG Communications Networks, Content and Technology under grant agreement No 825322.

### Why does this actually matter to end users?
Our smartphones and tablets are filled to the brim with photographs and videos we take of everything we see around us, so when we reach the memory limit of our devices, we need to put our vacation pictures, baby photos and nature videos somewhere we can easily access and sift through all of it. Many users rely on cloud storage to safely store these memories in our own personal vault, secured by a password (or two), handily synchronized across devices and easily accessible. But in practice, that is not always what cloud storage really is. What users in fact do, is store their own pictures and videos in some undefined location, as the cloud service provider rarely explains where data is kept (and under what local legislation), with little to no explanation about what access that service provider actually has to your private images.
One of the ways to keep your online pictures and videos safe and private, is to encrypt them before you save them online. But how then can you find that one picture of you and your friends out on the town that you want to put on the wall, or delete and select badly taken photos from your cloud space? Encryption in general is a proven technology to protect your privacy and strengthen your security, but can be hard to manage and maintain for users. The same thing goes for encrypting and storing photos and videos: users do not want to end up with a massive vault of unrecognizable data that they cannot search through or interact with in any meaningful way.
This project combines privacy protection and searchability of photos and videos in a user-friendly way. Visual recognition software is increasingly capable of accurately recognizing who and what can be seen in pictures and videos, which can be automatically tagged to the files as they are saved on your phone or tablet. The user can then decide where they want to store this content and whether they want to keep it safe and encrypted, all the while keeping the content searchable. Users do not have to give up agency over their own (very personal) photos and videos to any service provider that indexes and categorizes files: now they can do that themselves.

Of course, no one template will serve all projects since your needs may be different. So I'll be adding more in the near future. You may also suggest changes by forking this repo and creating a pull request or opening an issue. Thanks to all the people have contributed to expanding this template!


### Image tagging on the Edge
Sensifai develops a deep learning model that recognizes over 5000 different concepts trained over millions and millions of images using tensorflow. Then the developed model will be turned into TFLite. TensorFlow Lite (TFLite) is a collection of tools to convert and optimize TensorFlow models to run on mobile and edge devices. It was developed by Google for internal use and later open-sourced. Today, TFLite is running on more than 4 billion devices!


### Backup from image with encrypted data when user need
Images upload to user dropbox with encrypted data image, then user can download image on the phone.
Sensifai auto encrypt & decrypt image to upload & download image in flexible mode.


### How to generate APK?
1. Open the terminal and run below command in order to clone the code of Smart-gallery from Gitlab on your system:
```sh
git clone https://github.com/baharisensifai/Sensifai-Smart-Gallery.git
```

2. Now the source code of the app is available on your system, run below command in the terminal
to enter the folder:

```sh
cd Sensifai-Smart-Gallery
```

3. Checkout the main branch

```sh
git checkout main
```


4. To generate the .apk, run this command in the terminal:

```sh
flutter build apk
```

### Trainin dataset
We have applied the following dataset, which is a very large dataset covering +5000 tags, to train our AI model.
[Dataset Link](https://github.com/openimages/dataset/blob/main/READMEV2.md)

### Download app
Redirect to google drive for Download .apk file - 
<a href="https://drive.google.com/file/d/1xqJ3XHjxGG9i4REHiPgcuYz0RZonUYB-/view?usp=sharing">Download apk</a>


[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: flutter_01.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[DART]: https://img.shields.io/badge/dart-000000?style=for-the-badge&logo=dart&logoColor=white
[DART-URL]: https://dart.dev/
[React.js]: https://img.shields.io/badge/flutter-20232A?style=for-the-badge&logo=flutter&logoColor=61DAFB
[React-url]: https://flutter.dev/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com
[JQuery-url]: https://jquery.com 
[JQuery-url]: https://jquery.com 
