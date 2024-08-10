import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:omma_watson_flutter/answer/constants/badge_colors.dart';
import 'package:omma_watson_flutter/answer/models/food/food.dart';
import 'package:omma_watson_flutter/answer/models/question/question.dart';
import 'package:omma_watson_flutter/answer/widgets/foodtags/food_tags.dart';
import 'package:omma_watson_flutter/answer/widgets/view_nutrition_button.dart';
import 'package:omma_watson_flutter/api/api.dart';
import 'package:omma_watson_flutter/main.dart';
import 'package:omma_watson_flutter/utils/string.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

Food mockFood = Food.fromJson(
  {
    'id': '1',
    'content':
        '마라탕의 매운 정도와 당면의 양에 따라 소화에 부담을 줄 수 있습니다. 마라탕에 포함된 고추기름과 향신료는 위산 분비를 촉진하여 속쓰림을 유발할 수 있으며, 당면은 소화가 잘 되지 않아 더부룩함을 느낄 수 있습니다. 또한, 마라탕의 높은 나트륨 함량은 부종을 유발할 수 있어 주의가 필요합니다. (출처: 대한영양사협회)',
    'badge': 3,
    'solution': [
      '1단계로\n낮춰 보기',
      '물을 많이\n마시기',
      '채소를 많이 넣어 먹기',
    ],
    'feedback': {
      'comment':
          '대부분의 마미들이 임신 중 매운 음식은 주의해야 한다고 생각해요. 하지만 가끔 먹는 것은 괜찮다는 의견도 있어요.',
    },
    'products': [
      {
        'title': '바삭 통살 유린기 430g',
        'img':
            'https://wisely.store/web/product/big/202407/3d6659b8bfadb61310c5836ed94f5921.jpg',
        'price': {
          'original': 9200,
          'final': 6580,
        },
        'url':
            'https://wisely.store/product/detail.html?product_no=1681&cate_no=104&display_group=1',
      },
      {
        'title': '바삭 통살 유린기 430g',
        'img':
            'https://wisely.store/web/product/big/202407/3d6659b8bfadb61310c5836ed94f5921.jpg',
        'price': {
          'original': 9200,
          'final': 6580,
        },
        'url':
            'https://wisely.store/product/detail.html?product_no=1681&cate_no=104&display_group=1',
      },
      {
        'title': '바삭 통살 유린기 430g',
        'img':
            'https://wisely.store/web/product/big/202407/3d6659b8bfadb61310c5836ed94f5921.jpg',
        'price': {
          'original': 9200,
          'final': 6580,
        },
        'url':
            'https://wisely.store/product/detail.html?product_no=1681&cate_no=104&display_group=1',
      },
    ],
    'food_name': '마라탕', // 이렇게 바꿔서 검색하는데 쓸거
    'persona': '임신 24주차',
  },
);

class AnswerScreen extends StatefulWidget {
  const AnswerScreen({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  final api = Api(dio);

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        toolbarHeight: 48,
        leadingWidth: 64,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 28,
          ),
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: api.createNewQuestion(widget.question.copyWith(
              query: widget.question.query.stripHtmlIfNeeded(),
            )),
            builder: (ctx, snapshot) {
              print(snapshot);

              final Food food = snapshot.data ?? mockFood;

              if (snapshot.data == null) {
                return Skeletonizer(
                  enabled: true,
                  ignoreContainers: true,
                  effect: PulseEffect(),
                  child: bodyWidget(food),
                );
              }

              return bodyWidget(food);
            }),
      ),
    );
  }

  Widget bodyWidget(Food food) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 12,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...titleSection(food),
                      const SizedBox(height: 18),
                      ViewNutritionButton(
                        foodName: food.foodName,
                      ),
                    ],
                  ),
                ),
                bannerSection(food.badge),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      MarkdownBody(
                        data: food.content,
                        styleSheet: MarkdownStyleSheet(
                          p: Theme.of(context).textTheme.bodyLarge,
                        ),
                        onTapLink: (text, url, title) {
                          launchUrl(Uri.parse(url!));
                        },
                      ),
                      const SizedBox(height: 32),
                      ...solutionSection(food),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                // const Divider(
                //   height: 32,
                //   thickness: 8,
                //   color: Color(0xFFD9D9D9),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      ...momChoiceSection(food),
                      const SizedBox(height: 48)
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget skeletonBodyWidget(Food food) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 8),
                        child: Text(
                          'Recommend',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'My baby loves\nSteamed Duck with Chives!',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                      ),
                      const SizedBox(height: 18),
                      ViewNutritionButton(
                        foodName: food.foodName,
                      ),
                    ],
                  ),
                ),
                bannerSection(food.badge),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      MarkdownBody(
                        data: food.content,
                        styleSheet: MarkdownStyleSheet(
                          p: Theme.of(context).textTheme.bodyLarge,
                        ),
                        onTapLink: (text, url, title) {
                          launchUrl(Uri.parse(url!));
                        },
                      ),
                      const SizedBox(height: 32),
                      ...solutionSection(food),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                // const Divider(
                //   height: 32,
                //   thickness: 8,
                //   color: Color(0xFFD9D9D9),
                // ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      ...momChoiceSection(food),
                      const SizedBox(height: 48)
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bannerSection(int badge) {
    // String? backgroundImagePath;
    // String? foregroundImagePath;
    String? bannerImagePath;
    // double? padding;

    if (badge == 0) {
      // backgroundImagePath = 'assets/recommended_background.png';
      // foregroundImagePath = 'assets/recommended_character.png';
      bannerImagePath = 'assets/recommend_banner.png';
      // padding = 0;
    } else if (badge == 1) {
      // backgroundImagePath = 'assets/satisfactory_background.png';
      // foregroundImagePath = 'assets/satisfactory_character.png';
      bannerImagePath = 'assets/satisfactory_banner.png';
      // padding = 4;
    } else if (badge == 2) {
      // backgroundImagePath = 'assets/caution_background.png';
      // foregroundImagePath = 'assets/caution_character.png';
      bannerImagePath = 'assets/caution_banner.png';
      // padding = 25;
    } else if (badge == 3) {
      // backgroundImagePath = 'assets/dangerous_background.png';
      // foregroundImagePath = 'assets/dangerous_character.png';
      bannerImagePath = 'assets/dangerous_banner.png';
      // padding = 6;
    }

    return SizedBox(
      width: double.infinity,
      child: Image.asset(bannerImagePath!),
    );
  }

  List<Widget> solutionSection(Food food) {
    Gradient backgroundGradient = const LinearGradient(
      colors: [
        Color(0xFFB7FFFE),
        Color(0xFFF3F8FF),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    return [
      Text(
        food.badge != 3
            ? 'Better When Eaten This Way!'
            : 'Try those instead...',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 32),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Wrap(
          spacing: 12,
          children: food.solution
              .map(
                (solution) => Container(
                  width: 154,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: backgroundGradient,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      solution,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      )
    ];
  }

  List<Widget> titleSection(Food food) {
    return [
      FoodTags.getFoodTageByBadge(food.badge) ?? const SizedBox.shrink(),
      const SizedBox(height: 8),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: getTitleTextByBadge(food.badge),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
            ),
            TextSpan(
              text: food.foodName,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: BadgeColors.getColorByBadge(
                      food.badge,
                    ),
                  ),
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> momChoiceSection(Food food) {
    return [
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${food.persona} ',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF155CFF),
                  ),
            ),
            TextSpan(
              text: 'Moms\' Choices',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      const SizedBox(height: 18),
      Text(
        food.feedback.comment,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ];
  }

  List<Widget> opinionSection(Food food) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '의견 남기기',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFE6EDFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '다른 엄마들에게 큰 도움이 돼요!',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: const Color(0xFF155CFF),
                  ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      SizedBox(
        width: double.infinity,
        child: TextFormField(
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF91B2FF),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF91B2FF),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF91B2FF),
                width: 1,
              ),
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> productSection(Food food) {
    return [
      Text(
        '다음은 검증된 상품들이에요!',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        child: Wrap(
          spacing: 12,
          children: food.products
              .map(
                (product) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        width: 160,
                        height: 200,
                        product.imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(product.title),
                    const SizedBox(height: 8),
                    Text(
                      '${product.price.originalPrice}원',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${product.price.finalPrice}원',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '엄마 왓슨 특가',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    ];
  }

  List<Widget> buttonSection() {
    return [
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 64,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primary,
                  ),
                  foregroundColor: const WidgetStatePropertyAll(
                    Colors.white,
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  textStyle: WidgetStatePropertyAll(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                child: const Text('다른 질문하기'),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 64,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(
                    Color(0xFFE1EFFF),
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primary,
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  textStyle: WidgetStatePropertyAll(
                    Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                child: const Text('공유하기'),
              ),
            ),
          ),
        ],
      )
    ];
  }
}

String? getTitleTextByBadge(int badge) {
  if (badge == 0) {
    return 'My baby loves\n';
  } else if (badge == 1) {
    // return ' is okay to eat!';
    return 'Feel free to enjoy\n';
  } else if (badge == 2) {
    return 'Be cautious with\n';
  } else if (badge == 3) {
    return 'Extreme caution!\nRefrain from consuming ';
  }
  return null;
}
