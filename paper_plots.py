import matplotlib.pyplot as plt
import numpy as np

spring_const = 1
m = 1
b = 0.2
dt = 0.1

def iterate(state, K, state_desired):
    A = np.zeros((2,2))
    B = np.zeros(2).reshape(2,1)

    A[0,1] = 1
    A[1,0] = -spring_const/m
    A[1,1] = -b/m
    B[1] = 1/m

    u = K * (state_desired - state[0])

    state_dot = A.dot(state) + B*u
    print(state_dot)

    new_state = state + dt*state_dot

    return new_state

state = np.zeros(2).reshape(2,1)
state_data = np.array([state]).reshape(2,1)

nt = 1000
K = 1
pos_desired = 10

for i in range(nt - 1):
    new_state = iterate(state, K, pos_desired)
    print(new_state)
    state_data = np.hstack([ state_data, new_state ])

    state = new_state

t = np.linspace(0, dt*nt, nt)

plt.plot(t, state_data[0,:])
plt.xlabel("t")
plt.ylabel("Position")
plt.title("Proportional Constant = %4.2f" % K)
#plt.ylim(-5,15)
plt.show()
