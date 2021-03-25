### 숙제 2번 해설



**문제** : 부모가 각각 하나씩 물려주는 염색체가 눈동자 색을 결정한다. (xx : Bl, Xx 또는 XX : Br)

\* Xx와 xX는 구분하지 않고 사용			* 너무 간단한 계산은 생략

Pr(xx) = $p^2$, Pr(Xx) = $2p(1-p)$, Pr(XX) = $(1-p)^2$

Xx 염색체를 가질 때 (hetero) 각 염색체가 유전될 확률은 1/2이다.



### 1. Br 부모 -> Br 자녀가 Xx 염색체를 가질 확률은 $\dfrac{2p}{1+2p}$ 이다?

![1](/Users/soo._.yonee/Desktop/1.png)

분모 분자 정리하면 증명 가능 !



### Judy네 가계도

![2-1](/Users/soo._.yonee/Desktop/2-1.png)

### 2. Pr(Judy is Xx | n Childs Br, married Xx) = ??

![2-2](/Users/soo._.yonee/Desktop/2-2.png)

대충 생각하면 위와 같다. 부모가 모두 Br 갈색눈이라고 했으니 Judy가 xx(파란눈)일리는 없고 Xx거나 XX일텐데 그 중에 Xx일 상황에 관심이 있다.

여기서 known info는 Judy와 직접적으로 관련이 있는 사람들에 대해 우리가 알고 있는 정보들이다.

- n명의 자녀들이 모두 Br

​    ----사실 이 아래는 주어진 정보 (fixed constant)이다. 확률 어쩌구 할게 없음 ----

- Xx인 남편과 결혼함
- 부모님이 모두 Br

![2-3](/Users/soo._.yonee/Desktop/2-3.png)

**1번에서 부모가 갈색 눈이고 자녀도 갈색 눈일 때 그 자녀의 염색체가 Xx일 확률을 구했는데 그게 딱 Judy와 Judy의 부모님 이야기!**

기본적으로 그 전 세대(generation)의 정보를 주어진 것 (Prior)라고 생각하고 이전 세대의 정보를 활용하여 현재 세대의 정보에 대해 이야기하고자 함. 이 경우에도 무작정 Judy의 세대부터 추론을 해보려고 하면 마땅히 주어지는 정보가 없음. 위에서 P(Xx) = ~, P(XX) = ~ 이런게 주어지는 것 처럼 Judy의 부모님 세대에 대해서 뭐라도 정보가 있어야 Judy가 Xx인게 말이 되고 추론을 할 거 아닌가..

그러니까 여기서 부모 세대의 정보가 Prior의 역할을 한다. (라고 해설에 나와있기는 한데 Bayes rule 생각하지 말고 P(Xx) = ~, P(XX) = ~ 처럼 그냥 주어진 정보, 우리가 **확실**히 알고 있는 정보라고 생각하면 편함)

![2-4](/Users/soo._.yonee/Desktop/2-4.png)



### 3. Pr(Judy's 1st grandkid Blue eye a.k.a. xx | all info) = ??

\* 이 상황에서는 Judy가 Xx인지 XX인지 모름! 2번과 헷갈리면 안된다..

우선 Judy의 kid에 대해서 생각해보자.

Judy의 염색체 + 남편의 염색체 + 자녀 본인의 눈색깔로 Judy's kid의 염색체를 알 수 있는데 위에서 말했다시피 문제에서 남편의 염색체(Br-Xx)와 자녀 본인의 눈색깔 (Br)은 주어졌으므로 uncertain한 것은 Judy의 염색체 뿐이다. (Xx or XX)

Pr(Judy's kid Xx | all info so far) = Pr(Judy's kid Xx | Judy?+ kid Br+ 남편 Xx)

​	= Pr(Judy's kid Xx | **Judy Xx** + kid Br+ 남편 Xx)***Pr(Judy Xx+ kid Br+ 남편 Xx)** + Pr(Judy's kid Xx | **Judy XX** + kid Br+ 남편 Xx)***Pr(Judy XX+ kid Br+ 남편 Xx)**

이지만 식이 길어서 보기 불편하고 kid Br, 남편 Xx는 확실히 주어진 정보이니 짧게 써보면 다음과 같다.

Pr(Judy Xx+ kid Br+ 남편 Xx) => Pr(Judy Xx)라고 쓰겠음 --- now we know from #2

Pr(Judy's kid Xx | all info so far) = Pr(Judy's kid Xx | Judy?)

​	= Pr(Judy's kid Xx | **Judy Xx**) * **Pr(Judy Xx)** + Pr(Judy's kid Xx | **Judy XX**) * **Pr(Judy XX)**

​	= $\dfrac{\dfrac{1}{2}}{\dfrac{1}{2}+\dfrac{1}{4}} \dfrac{2p \Big(\dfrac{3}{4}\Big)^n}{2p \Big(\dfrac{3}{4}\Big)^n+1} + \dfrac{\dfrac{1}{2}}{\dfrac{1}{2}+\dfrac{1}{2}} \dfrac{1}{2p \Big(\dfrac{3}{4}\Big)^n+1} = \dfrac{2}{3} \dfrac{2p \Big(\dfrac{3}{4}\Big)^n}{2p \Big(\dfrac{3}{4}\Big)^n+1} + \dfrac{1}{2} \dfrac{1}{2p \Big(\dfrac{3}{4}\Big)^n+1}$

아래의 표 다시 참고!

<img src="/Users/soo._.yonee/Desktop/2-5.png" alt="2-5" style="zoom: 50%;" />

드디어 마지막!

![2-6](/Users/soo._.yonee/Desktop/2-6.png)

이제 우리는 Judy의 Child가 Xx일 확률을 알고 있다. 그럼 이제 uncertainty는 Judy의 child가 결혼할 배우자의 염색체에만 있으므로 그 부분만 확률을 계산해주면 된다.

Pr(Grandchild = xx | known info so far) = $\dfrac{\Big(\dfrac{2}{3}\Big) 2p \Big(\dfrac{3}{4}\Big)^n + \Big(\dfrac{1}{2}\Big)}{2p \Big(\dfrac{3}{4}\Big)^n+1}* (\dfrac{1}{2}p^2 + \dfrac{1}{4}2p(1-p)) = \dfrac{\Big(\dfrac{2}{3}\Big) 2p \Big(\dfrac{3}{4}\Big)^n + \Big(\dfrac{1}{2}\Big)}{2p \Big(\dfrac{3}{4}\Big)^n+1}* \dfrac{1}{2}p$ 



\* 정헌선배가 물어봤던 Judy의 자녀 중 누가 아이를 첫번째로 낳는지는 상관없는듯합니다. 모든 Judy의 n명의 자녀들에 대해 알 수 있는 모든 조건(Judy와 남편의 염색체, 자녀 본인 눈색은 갈색)이 동일하고 알려져있기 때문..!



풀이가 굉장히 장황해졌는데, 요는

- 각 세대 / 알고싶은 상황에 대해서 uncertain하기 때문에 경우를 나누어 생각해야하는게 무엇인지 vs. 우리가 확실히 확률을 알고 있는건 무엇인지(P(Xx)=~ 이런 것처럼 바로 쓸 수 있는 확률이 무엇인지)를 구별하는게 중요한 것 같고,
- 조건부 확률을 이용하는 방식이 여러 가지가 있을 수 있는데

$$P(A|B) = \dfrac{P(A,B)}{P(B)}$$   --- 요거는 1, 2번에서 주로 사용해서 문제를 해결하고

$$P(E) = \sum P(E|H_k)P(H_k)$$  --- 이런 law of total prob.를 3번에서 주로 사용해서 문제를 해결하면 될 것 같아요!

베이즈 정리와는 사실 별 상관 없는 문제입니다.



### 왜 굳이 Uninformative Prior 쓰는건가.. or 분명 나는 $\theta$에 대해 아무 생각이 없어서 uninformative prior를 썼는데 왜 업뎃된 Posterior에는 영향을 미치는가..

결론부터 말하자면 pdf가 1로 들어가서 변하는게 없어보여도 굳이 uniform prior를 쓰는 이유는 Frequentist 관점 말고 Bayesian Rule을 쓸건데 아무 생각이 없더라도 수학적으로 "아무 생각이 없다"라는 걸 잘 나타내려면 이게 최선이기 때문이다. "모르겠다"라는 걸 수학적으로 엄밀히 나타내기는 어렵고 어느 정도는 주관이 들어간 자의적인 선택이 될 수밖에 없는데, 그럼에도 불구하고

1) 어차피 데이터가 많아지면 prior의 영향은 미미하다

2) prior를 써서 베이즈 정리를 쓰는 효용이 훨씬 크다

이러니까 좀 마음에 걸려도 넘어가자! 이렇게 요약할 수 있다. 경훈오빠의 말에 따르면 통계학은 수학과는 약간 다르게 응용수학이라서 엄밀함 보다도 이렇게 사용하며 실제 문제 해결에 도움이 되는지가 중요하기 때문에 완벽한 엄밀성은 어느 정도 넘어가는 부분이 있는 것 같아요.

\* objective bayesian은 약간 강경보수같은 느낌? 구글링해보면 주관을 최대한 배제하고 베이즈 정리를 쓰겠다는 느낌인데 애초에 확률을 주관적인 믿음이라고 생각해서 베이지안 관점을 채택하는 건데 왜 굳이 주관을 배제하려고 하냐... 가 간사님의 답변입니다ㅎ



\* 그리고 왜 업뎃된 posterior에 미미하게나마 영향을 미치는지는 저도 정규님이 복습 스터디때 말했던 부분 정도까지만 생각할 수 있을 것 같아요. 말이 uninformative인거지 사실 $E[\theta]=\dfrac{1}{2}$같은 정보를 알 수 있으니까 약간이나마 변화시키는 것 같아요.



\* 이건 논외로, uniform prior에 대해서 제기되는 다른 문제점인데 $\theta$에 대해서 uniform한 prior를 주더라도 저희가 변수변환을 하게 되면 같은 분포이지만 변환된 변수에 대해서는 원래 줬던 prior가 uniform하지 않아지는 문제가 생깁니다.

예를 들어, Binomial model을 exponential family로 바꿔서 나타내면 아래와 같은데

<img src="/Users/soo._.yonee/Desktop/binomexp.png" alt="binomexp" style="zoom:50%;" />

이렇게 되면 함수의 파라미터를 p가 아니라 logit $\gamma = log\dfrac{p}{1-p} \in (-\infty, \infty)$로 바꿔서 생각할 수 있어요. 그렇게 되면 p~Unif(0,1)은 [0,1]에서는 uniform하고 uninformative하지만 그렇다고 logit $\gamma$가 $(-\infty, \infty)$에서 uniform하지는 않기 때문에 이런 scale invariant 문제가 존재합니다! 

그치만 결국 모수라는게 우리가 궁금한 것들을 나타내는 quantity이잖아요, 평균이 뭔지, 분산이 뭔지, 비율이 뭔지, 등등등. 그래서 우리가 궁금한 거에 대해서 uniform하게 주겠다!라고 말한다면 상관없는 거 아닐까 (라는게 간사님의 답변)