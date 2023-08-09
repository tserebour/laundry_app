class SliderModel {
  String imagePath;
  String title;
  String text;

  SliderModel(this.imagePath, this.title, this.text);

  static List<SliderModel> getSlides() {
    List<SliderModel> slides = [];
    SliderModel s1 = SliderModel("assets/images/formal.png", "Serve you",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. as vehicula ante nisl. Nullam faucibus purus sed tellus fermentum, ac porttitor metus laoreet. ");
    SliderModel s2 = SliderModel("assets/images/clean.png", "Dry it",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. tum, ac porttitor metus laoreet. ");
    SliderModel s3 = SliderModel("assets/images/washer.png", "Washing clothes",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.s purus sed tellus fermentum, ac porttitor metus laoreet. ");
    SliderModel s4 = SliderModel("assets/images/washer.png", "Washing clothes",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.s purus sed tellus fermentum, ac porttitor metus laoreet. ");
    slides.add(s3);
    slides.add(s2);
    slides.add(s1);
    slides.add(s4);
    return slides;
  }
}
