import pandas
import re
import math

#Evaluación REGREX
def evaluate_Fx(str_equ, valX):
  x = valX
  #strOut = str_equ
  strOut = str_equ.replace("x", str(valX))
  strOut = strOut.replace("e^", "math.exp(")
  strOut = strOut.replace("^", "**")
  strOut += ")"
  out = eval(strOut)
  return out

#Deferencias finitas para derivadas
def evaluate_derivate_fx(str_equ, x, h=1e-6):
  strOut_1 = str_equ.replace("x", str(x + h))
  strOut_1 = strOut_1.replace("e^", "math.exp(")
  strOut_1 = strOut_1.replace("^", "**")
  strOut_1 += ")"
  
  strOut_2 = str_equ.replace("x", str(x - h))
  strOut_2 = strOut_2.replace("e^", "math.exp(")
  strOut_2 = strOut_2.replace("^", "**")
  strOut_2 += ")"
  
  f_1 = eval(strOut_1)
  f_2 = eval(strOut_2)
  
  out = (f_1 - f_2) / (2 * h)
  return out


#Resolverdor de Newton
def newtonSolverX(x0, f_x, eps, k_max):
  x0 = float(x0)
  eps = float(eps)
  k_max = float(k_max)
  xn = x0
  error = 1
  k = 0
  arrayIters = []
  arrayXn = []
  arrayErr = []
  
  i = 0
  while(k < k_max):
    fxn = evaluate_Fx(f_x, xn)
    print(fxn)
    dfxn = evaluate_derivate_fx(f_x, xn)
    print (dfxn)
    if dfxn == 0: 
      print("Derivada cero")
      break

    x_n1 = xn - (fxn/dfxn)
    error = abs(x_n1 - xn)
    if (eps  > error): 
       break

    i = i + 1
    xn = x_n1
    arrayIters.append(i)
    arrayXn.append(xn)
    arrayErr.append(error)
    solution = [i, xn, error]
    k = k+1
  print("Finalizo...")
  TableOut = pandas.DataFrame({'Iter':arrayIters, 'Xn':arrayXn, 'Error': arrayErr})
  return TableOut

def add(a, b):
  a = int(a)
  b = int(b)
  resultado = a + b
  return "El resultado es: " + str(resultado)



def bisectionSolverX(a, b, f_x, eps, k_max):
  fa = evaluate_Fx(f_x, a)
  fb = evaluate_Fx(f_x, b)
  a = float(a)
  b = float(b)
  eps = float(eps)
  k_max = int(k_max)
  arrayIters = []
  arrayx_k = []
  arrayA = []
  arrayB = []
  arrayErr = []
  arrayfxk = []
  k = 0
  xk_prev = 0
  
  while k < k_max:
    arrayA.append(a)
    arrayB.append(b)
    arrayIters.append(k)
    
    xk = (a + b) / 2.0
    arrayx_k.append(xk)
    
    fxk = evaluate_Fx(f_x, xk)
    arrayfxk.append(fxk)

    if abs(fxk) <= eps:
        break
    
    
    error = abs(xk - xk_prev) / abs(xk)
    arrayErr.append(error)
    
    if fa * fxk < 0:
        b = xk
        fb = fxk
    else:
        a = xk
        fa = fxk
        
    xk_prev = xk
    k += 1
  TableOut = pandas.DataFrame({'Iter':arrayIters, 'x_k':arrayx_k, 'a': arrayA, 'b': arrayB, 'Error': arrayErr})
  return TableOut

  
