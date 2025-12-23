# -*- coding: utf-8 -*-

import numpy as np
import scipy.stats as stats


class Study:
    def __init__(self, category: str):
        self.category = category
        self.sen = None
        self.spe = None
        self.auc = None
        self.acc = None
        self.f1 = None
        self.yi = None
        self.ppv = None
        self.npv = None
        self.sample_size = None


def init_studies():
    study2 = Study('diagnosis')
    study2.auc = 0.9014
    study2.acc = 0.8925
    study2.sen = 0.9364
    study2.spe = 0.8987
    study2.f1 = 0.9196
    study2.sample_size = 333

    study3 = Study('diagnosis')
    study3.sen = 0.972
    study3.spe = 0.925
    study3.acc = 0.863
    study3.f1 = 0.887
    study3.sample_size = 217

    study4 = Study('diagnosis')
    study4.acc = 0.871
    study4.sen = 0.774
    study4.spe = 0.924
    study4.yi = 0.698
    study4.auc = 0.849
    study4.sample_size = 187
    
    study5 = Study('diagnosis')
    study5.acc = 0.8773
    study5.sen = 0.9417
    study5.ppv = 0.8381
    study5.f1 = 0.8738
    study5.sample_size = 554

    study6 = Study('diagnosis')
    study6.sen = 0.915
    study6.spe = 0.905
    study6.acc = 0.908
    study6.ppv = 0.796
    study6.npv = 0.963
    study6.auc = 0.910
    study6.sample_size = 161

    study7 = Study('ALNM')
    study7.auc = 0.93
    study7.acc = 0.93
    study7.sen = 0.88
    study7.spe = 0.95
    study7.sample_size = 197+591

    study8 = Study('diagnosis')
    study8.auc = 0.836
    study8.sen = 0.742
    study8.spe = 0.804
    study8.acc = 0.768
    study8.sample_size = 112+329

    study9 = Study('diagnosis')
    study9.sen = 0.892
    study9.spe = 0.771
    study9.auc = 0.910
    study9.sample_size = 25

    study10 = Study('diagnosis')
    study10.auc = 0.875
    study10.acc = 0.816
    study10.ppv = 0.841
    study10.sen = 0.920
    study10.f1 = 0.877
    study10.spe = 0.550
    study10.npv = 0.749
    study10.sample_size = 119

    study11 = Study('HER2')
    study11.auc = 0.869
    study11.sen = 1.000
    study11.spe = 0.668
    study11.acc = 0.722
    study11.sample_size = 104

    study12 = Study('HER2')
    study12.acc = 0.8623
    study12.ppv = 0.8594
    study12.sen = 0.8801
    study12.spe = 0.8704
    study12.auc = 0.876
    study12.sample_size = 335

    study13 = Study('prognosis')
    study13.auc = 0.91
    study13.sen = 0.894
    study13.spe = 0.829
    study13.sample_size = 239

    study14 = Study('ALNM')
    study14.auc = 0.77
    study14_1 = Study('prognosis')
    study14_1.auc = (0.79+0.83+0.78)/3
    study14.sample_size = 185+497
    study14_1.sample_size = 185+497

    study15 = Study('diagnosis')
    study15.auc = 0.953
    study15.yi = 0.814
    study15.sen = 0.875
    study15.spe = 0.802
    study15.acc = 0.854
    study15.ppv = 0.916
    study15.npv = 0.722
    study15_1 = Study('subtype')
    study15_1.auc = 0.960
    study15_1.yi = 0.823
    study15_1.sen = 0.465
    study15_1.spe = 0.816
    study15_1.acc = 0.725
    study15_1.ppv = 0.468
    study15_1.npv = 0.814
    study15.sample_size = 170
    study15_1.sample_size = 120

    study16 = Study('diagnosis')
    study16.auc = 0.84
    study16.sen = 0.708
    study16.spe = 0.859
    study16.acc = 0.760
    study16.f1 = 0.72
    study16.sample_size = 57+133

    study17 = Study('ALNM')
    study17.auc = 0.901
    study17.sen = 0.917
    study17.spe = 0.857
    study17.sample_size = 33+78

    study18 = Study('diagnosis')
    study18.auc = 0.891
    study18.sen = 0.888
    study18.spe = 0.750
    study18.acc = 0.819
    study18.sample_size = 80+254

    study19 = Study('diagnosis')
    study19.auc = 0.837
    study19.acc = 0.808
    study19.sen = 0.667
    study19.spe = 0.892
    study19.sample_size = 104+307

    study20 = Study('HER2')
    study20.acc = 0.7949
    study20.sen = 0.7062
    study20.spe = 0.7897
    study20.auc = 0.8082
    study20.sample_size = 39+80

    study21 = Study('ALNM')
    study21.auc = 0.810
    study21.acc = 0.841
    study21.sen = 0.688
    study21.spe = 0.879
    study21.npv = 0.921
    study21.ppv = 0.579
    study21.sample_size = 82+200

    study22 = Study('LVI')
    study22.auc = 0.914
    study22.acc = 0.816
    study22.sen = 0.911
    study22.spe = 0.775
    study22.npv = 0.952
    study22.ppv = 0.641
    study22.sample_size = 147+834

    study23 = Study('diagnosis')
    study23.auc = 0.896
    study23.sample_size = 106+233

    study24 = Study('ALNM')
    study24.acc = 0.8776
    study24.sen = 0.8182
    study24.spe = 0.9259
    study24.f1 = 0.8571
    study24.sample_size = 49+197

    study25 = Study('diagnosis')
    study25.sen = 0.9839
    study25.spe = 0.8889
    study25.acc = 0.9625
    study25.ppv = 0.9683
    study25.npv = 0.9412
    study25.auc = 0.936
    study25.sample_size = 80

    study26 = Study('subtype')
    study26.auc = (0.874+0.872+0.824)/3
    study26.acc = (0.848+0.800+0.756)/3
    study26.sen = (0.880+0.921+0.909)/3
    study26.spe = (0.810+0.823+0.706)/3
    study26.f1 = (0.863+0.667+0.645)/3
    study26.ppv = (0.846+0.818+0.500)/3
    study26.npv = (0.850+0.899+0.960)/3
    study26.sample_size = 58+135

    study27 = Study('diagnosis')
    study27.acc = 0.9845
    study27.ppv = 0.9825
    study27.sen = 0.9806
    study27.f1 = 0.9843
    study27.sample_size = 3390

    study28 = Study('diagnosis')
    study28.auc = 0.949
    study28.acc = 0.851
    study28.sen = 0.973
    study28.spe = 0.804
    study28.npv = 0.987
    study28.f1 = 0.783
    study28.sample_size = 134+199

    study29 = Study('ALNM')
    study29.auc = 0.713
    study29.sen = 0.6667
    study29.spe = 0.7273
    study29.acc = 0.6667
    study29.sample_size = 24+219

    study30 = Study('diagnosis')
    study30.auc = 0.72
    study30.sen = 0.68
    study30.spe = 0.69
    study30.sample_size = 131

    study31 = Study('HER2')
    study31.auc = 0.969
    study31.sen = 0.9286
    study31.spe = 0.9634
    study31.acc = 0.9524
    study31.sample_size = 42+98

    study32 = Study('subtype')
    study32.auc = 0.89
    study32.sen = 0.81
    study32.f1 = 0.89
    study32.acc = 0.89
    study32.sample_size = 208+1180

    study33 = Study('ALNM')
    study33.auc = 0.903
    study33.sen = 0.900
    study33.spe = 0.800
    study33.sample_size = 401

    study34 = Study('diagnosis')
    study34.auc = 0.943
    study34.acc = 0.88238
    study34.sen = 0.90910
    study34.spe = 0.90432
    study34.f1 = 0.88038
    study34.sample_size = 332

    study35 = Study('diagnosis')
    study35.auc = 0.966
    study35_1 = Study('ALNM')
    study35_1.auc = 0.832
    study35.sample_size = 253
    study35_1.sample_size = 253

    global studies
    studies = [study2, study3, study4, study5, study6, study7, study8, study9, study10, study11, study12, study13, study14, study14_1, study15, study15_1, study16, study17, study18, study19, study20, study21, study22, study23, study24, study25, study26, study27, study28, study29, study30, study31, study32, study33, study34, study35, study35_1]


def get_mean(task:list, performance):
    included_num = []
    sample_size = 0
    for iStudy in task:
        if getattr(iStudy, performance, False):
            included_num.append(getattr(iStudy, performance))
            sample_size += iStudy.sample_size
    data = np.array(included_num)
    n = len(data)
    mean = np.mean(data)
    sem = stats.sem(data)
    ci = stats.t.interval(confidence=0.95, df=n-1, loc=mean, scale=sem)
    if mean:
        return mean, n, sample_size, ci
    else:
        return 0, 0, 0, (0, 0)


def calculate(task:list):
    result = []
    performances = ['sen', 'spe', 'auc', 'acc', 'ppv', 'npv', 'f1', 'yi']
    for performance in performances:
        result.append(get_mean(task, performance))

    for r in result:
        print(f'{round(r[0], 3)} (95% CI {round(r[3][0], 4)}-{round(r[3][1], 4)}) ({r[2]} / {r[1]})')


def main():
    init_studies()
    categories = []
    for study in studies:
        if study.category not in categories:
            categories.append(study.category)
    # print(categories)
    diagnosis = []
    ALNM = []
    HER2 = []
    prognosis = []
    subtype = []
    LVI = []
    for study in studies:
        if study.category == 'diagnosis': diagnosis.append(study)
        if study.category == 'ALNM': ALNM.append(study)
        if study.category == 'HER2': HER2.append(study)
        if study.category == 'subtype': subtype.append(study)
        if study.category == 'prognosis': prognosis.append(study)
        if study.category == 'LVI': LVI.append(study)
    a = 0
    for group in [diagnosis, ALNM, HER2, prognosis, subtype, LVI]:
        for i in group:
            a += 1
    # print(a)
    print('\n---Diagnosis---')
    calculate(diagnosis)
    print('\n---LNM---')
    calculate(ALNM)
    print('\n---HER2---')
    calculate(HER2)
    print('\n---Subtype---')
    calculate(subtype)
    print('\n---Prognosis---')
    calculate(prognosis)
    print('\n---LVI---')
    calculate(LVI)


if __name__ == '__main__':
    main()