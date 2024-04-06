︠3d25a69c-655e-499d-a585-2608671d56fcs︠
# Define factors in \circ-product:
# Enter the indices of the b_n generators as the components of each vector, and ignore the [x_i] generators for now. For example, [x_2] \circ b_1 \circ b_2 becomes [1,2]

a = vector(ZZ,[1])

b = vector(ZZ,[1])

# Set up list of \#-summands

from itertools import chain
c = vector(chain(a,b))

S = list()

for i in list(IntegerRange(1,len(c)+1)):
    S = S + [list(IntegerRange(1,c[i-1]+1))]

zero = zero_vector(ZZ,len(c))

T = list(list([zero]) + list(cartesian_product(S)))

print('Factors:',a,b)

print('Product:')

for u in list(T):
    u = vector(u)
    v = c[:len(a)]-u[:len(a)]
    w = c[len(a):len(c)+1] - u[len(a):len(c)+1]
#    print([v,w,u]) # uncomment to check that vectors are all being computed correctly.
    if prod(v) != 0 and prod(w) != 0:
        print([v,w,u])
    if prod(v) == 0 and sum(v) == 0 and prod(w) != 0:
        print([v,w,u])
    if  prod(v) != 0 and prod(w) == 0 and sum(w) == 0:
        print([v,w,u])
    if prod(v) == 0 and sum(v) == 0 and prod(w) == 0 and sum(w) == 0:
        print([v,w,u])
︡2511a5a0-9e8d-469b-96eb-96a51ee32935︡{"stdout":"Factors: (1) (1)\n"}︡{"stdout":"Product:\n"}︡{"stdout":"[(1), (1), (0, 0)]\n[(0), (0), (1, 1)]\n"}︡{"done":true}
︠f2581f48-2187-44eb-9b02-0596d0937ecas︠

M = [[1],[1]]

N = [[1],[1]]

#### Define coproduct of M ####

S = list()
T = list()
v = zero_vector(ZZ,len(N)+1)

for i in IntegerRange(0,len(M)):
    for j in IntegerRange(0,len(M[i])):
        S = list()
        for k in IntegerRange(1,min(M[i][j],len(N)+1)+1):
            for p in Partitions(M[i][j],length=k).list():
                for l in Permutations(range(len(v)),k).list():
                    v = zero_vector(ZZ,len(N)+1)
                    n=-1
                    for m in l:
                        n = n+1
                        v[m] = p[n]
#                print(v)
                    if v not in S:
                        S = S + [v]
#        print(S)
        T = T + [S]
#        print(T)

#print(T)

#### Define coproduct of N ####

S = list()
U = list()
v = zero_vector(ZZ,len(M)+1)

for i in IntegerRange(0,len(N)):
    for j in IntegerRange(0,len(N[i])):
        S = list()
        for k in IntegerRange(1,min(N[i][j],len(M)+1)+1):
            for p in Partitions(N[i][j],length=k).list():
                for l in Permutations(range(len(v)),k).list():
                    v = zero_vector(ZZ,len(M)+1)
                    n=-1
                    for m in l:
                        n = n+1
                        v[m] = p[n]
#                print(v)
                    if v not in S:
                        S = S + [v]
#        print(S)
        U = U + [S]
#        print(U)

#print(U)

#### Set up independent choice of summands in coprducts ####

TT = list(cartesian_product(T))

UU = list(cartesian_product(U))

####### FULL FOR LOOP OVER BOTH t in TT and u in UU #####

print('Factors:', M, 'and', N)

print('Product:')

for t in TT:
    PM = []
    for l in IntegerRange(len(N)+1):
        k = -1
#        print(l) # Uncomment to keep track of loop when reviewing RM, QM or PM
        QM = []
        for i in IntegerRange(len(M)):
            RM = []
            for j in IntegerRange(len(M[i])):
                k = k + 1
                RM = RM + [t[k][l]]
#                print(RM) # Uncomment to check that RM is being computed correctly.
            QM = QM + [RM]
#            print(QM) # Uncomment to check that QM is being computed correctly.
        QM = [[]] + QM
        PM = PM + [QM]
#        print(PM) # Uncomment to check that PM is being computed correctly.
#    print(PM)
    for u in UU:
        PN = []
        for l in IntegerRange(len(M)+1):
            k = -1
#            print(l) # Uncomment to keep track of loop when reviewing RN, QN or PN
            QN = []
            for i in IntegerRange(len(N)):
                RN = []
                for j in IntegerRange(len(N[i])):
                    k = k + 1
                    RN = RN + [u[k][l]]
#                    print(RN) # Uncomment to check that RN is being computed correctly.
                QN = QN + [RN]
#                print(QN) # Uncomment to check that QN is being computed correctly.
            QN = [[]] + QN
            PN = PN + [QN]
#            print(PN) # Uncomment to check that PN is being computed correctly.
        P = []
        for i in IntegerRange(len(N)+1):
            for j in IntegerRange(len(M)+1):
                P = P + [PM[i][j] + PN[j][i]]
        if all(sum(P[i]) == 0 or prod(P[i]) != 0 for i in IntegerRange(len(P))):
            print('plus')
            print(P)

print('row length:', len(M)+1)

︡b1b9596f-8326-405b-9ae0-30c9f49a9f8e︡{"stdout":"Factors: [[1], [1]] and [[1], [1]]\n"}︡{"stdout":"Product:\n"}︡{"stdout":"plus\n[[], [1], [1], [1], [0, 0], [0, 0], [1], [0, 0], [0, 0]]\nplus\n[[], [1], [0], [0], [0, 0], [1, 1], [1], [0, 0], [0, 0]]\nplus\n[[], [1], [0], [1], [0, 0], [0, 0], [0], [0, 0], [1, 1]]\nplus\n[[], [0], [1], [0], [1, 1], [0, 0], [1], [0, 0], [0, 0]]\nplus\n[[], [0], [0], [0], [1, 1], [0, 0], [0], [0, 0], [1, 1]]\nplus\n[[], [0], [1], [1], [0, 0], [0, 0], [0], [1, 1], [0, 0]]\nplus\n[[], [0], [0], [0], [0, 0], [1, 1], [0], [1, 1], [0, 0]]\n"}︡{"stdout":"row length: 3\n"}︡{"done":true}









