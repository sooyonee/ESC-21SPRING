## 21-1 ESC Final Project Guideline 🗂

### 1. Goal

- Difference between Frequentist point of view and Bayesian point of view
- Interpreting model in Bayesian perspective
- 예측 보다는, "해석"이 주 목적



### 2. Workflow

**1주차 : Choose dataset / Prep-processing / Feature Extraction / EDA+Visualization**

데이터 분석 이전에 데이터의 개형을 파악하고 직관을 얻는 단계입니다. 해야할 일은 다음과 같습니다. 

- **Choosing Dataset** : 아래 소개될 데이터셋 중 하나를 선택합니다. 꼭 주어진 데이터를 선택하지 않아도 됩니다. 제시된 데이터셋이 아닌 새로운 데이터를 사용하거나, 제공된 데이터의 예측 변수를 다른 변수로 정의하거나, 추가로 데이터를 붙여서 분석을 하는 것 모두 좋습니다.
  **⏰ 5월 21일 금요일 오후 7시까지 학술부장에게 개인톡으로 어떤 데이터셋을 사용할건지 1, 2지망을 알려주세요. 선착순이고, 이는 가능하면 각 데이터당 두 조를 넘지 않게 조정하고자 함입니다. **

- **Pre-Processing** : 데이터의 특성상 전처리가 필요한 경우가 있습니다. 예를 들어, 시계열 변수가 포함되어 있거나, 범주형 변수를 numeric하게 코딩하기, NA imputation 등이 있을 수 있습니다. 또한 데이터의 분포와 단위 차이를 모두 고려하여 적절하게 변환 및 스케일링을 해야 합니다. 모든 변수의 분포가 같을 필요는 없지만, 같은 단위에 있는 것이 바람직합니다. 

- **Feature Extraction** : 여러 변수를 합쳐서 새로운 변수를 만들거나, 외부 데이터에서 얻은 변수로 새로운 feature를 추가하거나, correlation analysis 등을 통해 multicolinearity가 있는 변수를 분석에서 제외하는 등의 작업입니다. 변수들 끼리 상관관계가 높은 경우 단순히 삭제를 할 수도 있고, 잠재변수를 바탕으로 새로운 변수를 만들 수도 있습니다.

  📍 **주의: 변수 선택 단계가 아닙니다! 변수 선택은 모델을 세우고 난 후에 진행합니다!**

- **EDA+Visualization** : EDA는 Pre-Processing과 Feature Extraction과 병행하여 데이터에 대해 알아가는 1주차 전반에 걸쳐 시행합니다. 기본적인 기술통계량이나 skewness를 보거나, normal assumption을 적용할 수 있는지, 변수 재정의가 필요하지는 않은지 파악합니다. 또한, 데이터의 분포를 눈으로 파악하는 것이 직관을 줄 수 있습니다. 설명변수와 응답변수 간, 혹은 설명변수 간의 산점도를 그려 선형/비선형 관계를 파악하거나, 데이터 이해에 도움이 되는 시각화를 해봅니다.

📚 reference : 1주차 / 5주차 데이터 분석 예시 노트북, 공모전 리더보드, ESC 예전 파이널 프로젝트 repo 등등!



👩🏻‍💻 **중간점검 (Week 10 : May 27th)** : 다음 주 세션에서 이번학기 새로 부임하신 정성현 교수님이 30분 정도 짧게 특강을 해 주실 예정입니다! 교수님 특강 후에 조별로 돌아가면서 10분 내외로 간단하게 소개한 데이터 설명, 1주차 수행 결과를 간단히 발표해주시고, 어려운 점이나 궁금한 점을 공유해주시면 됩니다.



**2주차 : Modeling / Model Selection / Interpretation**

Bayesian Linear Regression 방법을 사용해 전 주에 준비한 설명변수들을 종합적으로 고려하여 모델을 만듭니다.

- **Modeling** : Frequentist 관점에서 일반적인 회귀 모형을 우선 적합시켜 보고, Bayesian Linear Regression을 통해서도 학습을 진행합니다. 두 방법론 간에 어떤 차이가 있을까요?

- **Model Selection** : 모델 설렉션의 의미는 크게 2 가지입니다. 모델의 CV 에러(Bias - Variance Tradeoff), 모델의 해석 가능 여부 등을 고려합니다.

  1. 모델 자체의 선택: 예컨대 로지스틱 회귀를 쓸지, SVM을 쓸지, Random Forest를 쓸지, 혹은 이 모두를 함께 쓰는 Voting Classifier를 쓸지 결정합니다.
  2. 모델 내 변수의 선택: 어떤 변수를 쓸지, 어떤 잠재변수를 고려할지 등을 결정합니다. (이번 주에 배운 내용!)

  그렇지만 이번 프로젝트의 경우 크게 linear regression 한 가지 모델을 사용하기 때문에 2번 모델 내 변수의 선택에 해당합니다.

  빈도론적 관점에서 회귀분석을 실시하였다면 forward / backward selection, information criterion 등을 사용하여 model selection을 할 수 있겠고, 이번 주에 배운 내용을 토대로 Bayesian model selection을 통해서도 feature selection을 하여 결과를 비교해보세요. 두 관점 모두에서 적용 및 해석이 가능한 Lasso / Ridge 등의 penalizing method를 사용할 수도 있습니다.

- **Interpretation** : Evaluation이 주된 목적은 아니지만 분석 과제에 맞게 metric을 정하고 그를 바탕으로 모델의 성능을 평가합니다. 공모전 데이터처럼 metric이나 평가에 사용하는 score가 정해져 있는 경우도 있고, 단순 MSE를 사용할 수도, binary classification이라면 contingency table을 보는 방법 등이 있습니다. 잘 예측하는 것도 중요하지만 그에 못지않게 모델을 설명할 수 있는 것도 중요합니다. 예를 들어, 어떤 변수가 중요한지 (나아가 왜 중요한지 나름의 해석이 있으면 좋겠죠?), 회귀 계수나 feature selection의 Importance 값을 근거로 제시하고 그 이유를 생각해보면 됩니다.

  

👩🏻‍💻 **최종 발표 (Week 11 : June 3rd)** : 2주 간 파이널 프로젝트를 수행한 내용을 팀별로 15분 이내로 발표해주세요. 뉴럴넷이나 부스팅 등의 방법을 사용하지 않기 때문에 score 자체는 좋지 않을 수도 있습니다. 이번 프로젝트에서는 결과가 좋지 않더라도 왜 좋지 않았을지 생각해본 내용이나 improvement 등을 고민해보시고 발표해주세요. 한 학기동안 배운 내용과 연관지어 결과를 잘 해석하고 모델과 변수를 잘 설명하는 게 중요합니다!



### 3. Datasets

\* 아래에 제시된 데이터셋 외에 다른 데이터셋을 사용하셔도 무방합니다!

#### Regression Problem

- **[DACON] 아파트 경매가격 예측**

  - 아파트 낙찰가 예측하기

    한국의 서울과 부산 지역 약 2,700여개 최근 2년간 아파트 경매물의 등기부, 임차, 감정가, 유찰 횟수, 낙찰가 등의 정보가 제공됩니다. 

  - original link : https://dacon.io/competitions/official/17801/data

    (비슷한 데이터로 kaggle의 house price 예측 데이터가 있습니다 : https://www.kaggle.com/c/house-prices-advanced-regression-techniques/data)

  - evaluation metric : RMSE (Root Mean Squared Error)

  - 자세한 description은 dacon 홈페이지를 참조

  - 특이사항 : test set의 정답이 따로 제공되지 않는듯하므로 train test에서 적당히 split 필요



- **[UCI / ESC] 범죄지도 만들기**

  - 베이지안 method를 이용하여 범죄지도 완성하기
  - 2215 obs. of 147 variables
  - 8종 범죄 : murders / rapes / robberies / assaults / burglaries / larcenies / autoTheft / arsons
  - original src : http://archive.ics.uci.edu/ml/datasets/communities+and+crime (dimension 약간 다름)
  - 결측치 O
  - recommended materials : https://statkclee.github.io/spatial/
  - 특이사항 : mapping & rigorous visualization, many multiple response variables

  

- **[ASA Datafest / Microsoft Build] Predicting Airline Delay**

  - 비행기 도착지연시간 예측하기 (arr_delay)

  - Airline on-time performance data for the years 1987 through 2008 was used in the American Statistical Association Data Expo in 2009 (http://stat-computing.org/dataexpo/2009/). ASA describes the data set as follows:

    > The data consists of flight arrival and departure details for all commercial flights within the USA, from October 1987 to April 2008. This is a large dataset: there are nearly 120 million records in total, and takes up 1.6 gigabytes of space compressed and 12 gigabytes when uncompressed.

    월별 데이터는 따로 받을 수 있고, `AirOnTime87to12.xdf` 가 전체 data (압축 해제 시 12GB...), 전체 data 중 7% 정도만 추출한 것이 `AirOnTime7Pct.xdf`이다.

    Row 수가 굉장히 많기 때문에 2012년도의 data 또는 특정 연도의 data를 골라서 사용하는 것을 권장 

    2012 : https://packages.revolutionanalytics.com/datasets/AirOnTimeCSV2012/

    1987-2008 database : https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi%3A10.7910%2FDVN%2FHG7NV7&version=&q=&fileTypeGroupFacet=&fileAccess=&fileSortField=name&fileSortOrder=desc

    2015 : https://www.kaggle.com/usdot/flight-delays/code?datasetId=810&sortBy=voteCount

  - 특이사항 : large data, 시계열 변수 O, 결측치 O, 범주형 변수

    (원래는 Microsoft Build에서 대용량 데이터를 클라우드 환경에서 분석하는 예시에서 사용됨. 혹시라도 150million record가 전부 포함된 .xdf 파일을 사용해보고 싶은 팀은 https://docs.microsoft.com/en-us/machine-learning-server/r/tutorial-revoscaler-large-data-airline#download-the-airline-dataset 참조. Microsoft / linux 환경에서만 가능)

  

#### Classification Problem (Binary Response - Logistic Regression / GLM)

\* Logistic problem을 선택하신 분들은 간사님께서 따로 모델링에 들어가기 전에 조금 더 심화된 방법론이랑 코드를 설명해 주실 예정입니다! (중간발표 전날 정도?)

- **[COMPAS] 김해시 화재발생 예측모델**
  
  - 경남지역 데이터를 이용해, 김해시의 화재 발생을 예측하기
  
  - 63 columns / fr_yn 예측 (binary response)
  - train (경남지역) / validation (김해지역) set
  - 결측치 여부 O / 시계열 변수 O
  - original link : https://compas.lh.or.kr/subj/past/info?subjNo=SBJ_1910_002
  - 자세한 description은 compas 홈페이지를 참조



- **[KAGGLE] ALL-NBA awards 수상 예측**

  - ALL-NBA 수상 예측 (binary response)

  - description : kaggle의 1950년도부터 NBA 선수들의 시즌 스탯 데이터에 제가 당해 ALL-NBA 수상 여부를 binary variable로 붙인 데이터입니다.

    The All-NBA Team is an annual NBA awards given to the best players in the league every following season, whose vote is conducted by a panel of sportswriters and broadcasters. The award dates back to 1946, however, since 1988 the ALL-NBA team is composed of three teams of 5 players. Being included in the team is a great honor for players and it affects players’ reputation and value.

    Dataset : Players and season stats data from Kaggle contains aggregate individual statistics for 67 NBA seasons from 1950 to 2017. There are 59 columns, data originally scraped from basketball-reference.com. Features include standard statistics (e.g. points, rebounds, turnover, etc.), advanced metrics (e.g. Player Efficiency Rate, Win Share, etc.), and categorical variables (e.g. position, team)

    1989 = 1988-1989 season

    15582 rows

  - train / test set을 어떻게 나눠야 할지 생각해보세요!
  
  - original link : https://www.kaggle.com/drgilermo/nba-players-stats?select=player_data.csv
  
  - 예측변수를 salary로 바꾸면 classification problem이 아니라 regression problem으로 풀 수 있습니다!
  
    https://www.kaggle.com/whitefero/nba-player-salary-19902017
  
    (\* 다만 이렇게 하려면 data integration을 해서 합쳐진 두 데이터가 쓸 만 한지 사전에 체크해 보셔야 합니다!)
    
  - 특이사항 : 결측치 O, class imbalance, categorical variables, 농구에 대한 해박한 지식 필요..



- **BCG customer churn 예측**
  - BCG case competition data
  - 여러분들이 Boston Consulting Group의 consultant라고 생각하고 고객인 에너지 회사 PowerCo의 고객 이탈 여부를 예측하고 어떻게 하면 이탈을 막을 수 있을지 방안 제시하기
  - binary response
  - case description / code book 제공



### 4. Reference

**[demo]**

\- R : https://github.com/avehtari/modelselection

\- python : https://www.quantstart.com/articles/Bayesian-Linear-Regression-Models-with-PyMC3/

**[article]**

\- https://towardsdatascience.com/introduction-to-bayesian-linear-regression-e66e60791ea7

그 외 구글링, 또 구글링...