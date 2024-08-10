import 'package:flutter/material.dart';
import 'package:omma_watson_flutter/answer/constants/badge_colors.dart';
import 'package:omma_watson_flutter/answer/models/food/food.dart';
import 'package:omma_watson_flutter/answer/widgets/foodtags/danger_food_tag.dart';
import 'package:omma_watson_flutter/answer/widgets/foodtags/food_tags.dart';
import 'package:omma_watson_flutter/answer/widgets/foodtags/safe_food_tag.dart';
import 'package:omma_watson_flutter/answer/widgets/ratio_bar.dart';
import 'package:omma_watson_flutter/answer/widgets/view_nutrition_button.dart';

Food mockFood = Food.fromJson(
  {
    'id': '1',
    'content':
        '마라탕의 매운 정도와 당면의 양에 따라 소화에 부담을 줄 수 있습니다. 마라탕에 포함된 고추기름과 향신료는 위산 분비를 촉진하여 속쓰림을 유발할 수 있으며, 당면은 소화가 잘 되지 않아 더부룩함을 느낄 수 있습니다. 또한, 마라탕의 높은 나트륨 함량은 부종을 유발할 수 있어 주의가 필요합니다. (출처: 대한영양사협회)',
    'badge': '위험',
    'solution': [
      '1단계로\n낮춰 보기',
      '물을 많이\n마시기',
      '채소를 많이 넣어 먹기',
    ],
    'feedback': {
      'good': 45,
      'bad': 12,
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
  const AnswerScreen({super.key});

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  final ScrollController _scrollController = ScrollController();

  double scrollOffset = 0;

  _scrollListner() {
    if (_scrollController.offset < 300) {
      setState(() {
        scrollOffset = _scrollController.offset;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListner);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverSafeArea(
              sliver: SliverAppBar(
                pinned: true,
                floating: true,
                toolbarHeight:
                    scrollOffset < 140 ? 80 - ((scrollOffset / 140) * 40) : 40,
                backgroundColor: scrollOffset < 140
                    ? Theme.of(context).colorScheme.primary
                    : Colors.white,
                surfaceTintColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  title: Center(
                    child: Text(
                      '마라탕 2단계로 먹어도 되나요?',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color:
                              scrollOffset < 140 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20 - ((scrollOffset / 140) * 4)),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      ...titleSection(),
                      const SizedBox(height: 16),
                      const ViewNutritionButton(),
                      const SizedBox(height: 16),
                      Container(
                        color: Colors.grey[300],
                        width: double.infinity,
                        height: 210,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        mockFood.content,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 40),
                      ...solutionSection(),
                      const SizedBox(height: 40),
                      ...momChoiceSection(),
                      const SizedBox(height: 40),
                      ...opinionSection(),
                      const SizedBox(height: 40),
                      ...productSection(),
                      const SizedBox(height: 40),
                      ...buttonSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> solutionSection() {
    return [
      Text(
        '꼭 먹어야 한다면?',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 12,
          children: mockFood.solution
              .map(
                (solution) => Container(
                  width: 154,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade200,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      solution,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
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

  List<Widget> titleSection() {
    return [
      FoodTags.getFoodTageByBadge(mockFood.badge) ?? const SizedBox.shrink(),
      const SizedBox(height: 8),
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: mockFood.foodName,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: BadgeColors.getColorByBadge(mockFood.badge),
                  ),
            ),
            TextSpan(
              text: getTitleTextByBadge(
                  mockFood.foodName[mockFood.foodName.length - 1],
                  mockFood.badge),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> momChoiceSection() {
    return [
      Text(
        '마미들의 선택',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      Text(
        mockFood.feedback.comment,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      const SizedBox(height: 16),
      FeedbackRatioBar(
        good: mockFood.feedback.good,
        bad: mockFood.feedback.bad,
      ),
    ];
  }

  List<Widget> opinionSection() {
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

  List<Widget> productSection() {
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
        child: Wrap(
          spacing: 12,
          children: mockFood.products
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

String? getTitleTextByBadge(String lastWord, String badge) {
  bool finalConsonant = hasFinalConsonant(lastWord);

  if (badge == '추천') {
    return (finalConsonant) ? '을 아기가 좋아해요!' : '를 아기가 좋아해요!';
  } else if (badge == '양호') {
    return (finalConsonant) ? '은 먹어도 괜찮아요!' : '는 먹어도 괜찮아요!';
  } else if (badge == '주의') {
    return (finalConsonant) ? '은 주의가 필요해요!' : '는 주의가 필요해요!';
  } else if (badge == '위험') {
    return (finalConsonant) ? '은 주의가 필요해요!' : '는 주의가 필요해요!';
  }
  return null;
}

bool hasFinalConsonant(String char) {
  const int baseCode = 0xAC00;
  const int finalConsonantCount = 28;

  int codeUnit = char.codeUnitAt(0);

  if (codeUnit < 0xAC00 || codeUnit > 0xD7A3) {
    return false;
  }

  int syllableIndex = codeUnit - baseCode;
  int finalConsonantIndex = syllableIndex % finalConsonantCount;

  return finalConsonantIndex > 0;
}
