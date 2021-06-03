import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/model/source.dart';
part 'article.g.dart';


/*
// source : {"id":null,"name":"OregonLive"}
/// author : "Aimee Green | The Oregonian/OregonLive"
/// title : "Oregon governor says she will close indoor dining next Friday in some counties if COVID hospitalizations cont - OregonLive"
/// description : "The threshold for moving counties to \"extreme risk\" will be triggered when Oregon reaches 300 hospitalized COVID-19 patients. That's expected to happen any day."
/// url : "https://www.oregonlive.com/news/2021/04/oregon-governor-says-she-will-close-indoor-dining-next-friday-in-12-counties-if-covid-hospitalizations-continue-to-spike.html"
/// urlToImage : "https://www.oregonlive.com/resizer/sZHL8u729q9QjAgRBaY8JYFCgSs=/1280x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/VXZXNDKH3VBQJHABZ6454VYAVM.JPG"
/// publishedAt : "2021-04-23T19:50:10Z"
/// content : "In her most serious and stark tone in weeks, Oregon Gov. Kate Brown said Friday that she will shut down indoor dining in bars and restaurants in 12 counties at the end of next week if COVID-19 cases … [+3301 chars]"

 */
@JsonSerializable()
class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content});

  factory Article.fromJson(Map<String,dynamic> json) => _$ArticleFromJson(json);

  Map<String,dynamic> toJson() => _$ArticleToJson(this);
}
