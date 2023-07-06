import numpy as np
import matplotlib.pyplot as plt


t = np.linspace(0,4570)
tau = 65 #mya
alpha = 0.6
T = 4570 - t
F = 225 * np.exp(-(t/tau)**alpha) + 3E-3 * T
