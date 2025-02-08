# Описание домашнего задания №2 по Git  

1. В локальном репозитории **da_course** создайте ветку ***hw25***
2. В ветке создайте файл *factorial.py*
3. Сохраните и закомитьтесь.
4. Находясь на ветке ***hw25*** создайте новую ветку ***feature/recursive*** но пока не переходите на неё
5. Вставьте в файл *factorial.py* следующий код:
```
def factorial(n, method="iterative"):
    if method == "iterative":
        result = 1
        for i in range(1, n + 1):
            result *= i
        return result
    else:
        # Placeholder for recursive method
        pass

if __name__ == "__main__":
    number = 5
    method = input("Choose method (iterative/recursive): ").strip().lower()
    print(f"Factorial of {number} is {factorial(number, method)}")
```
6. Сохраните изменения и закомитьте
7. Перейдите на ветку ***feature/recursive***
8. Вставьте в файл следующий код:
```
def factorial(n, method="iterative"):
    if method == "recursive":
        if n == 0 or n == 1:
            return 1
        else:
            return n * factorial(n - 1, method="recursive")
    else:
        # Placeholder for iterative method
        pass

if __name__ == "__main__":
    number = 5
    method = input("Choose method (iterative/recursive): ").strip().lower()
    print(f"Factorial of {number} is {factorial(number, method)}")
```
9. Сохраните изменения и закомитьте
10. Вернитесь на ветку ***hw25***
11. Произведите слияние с веткой ***feature/recursive***, с помощью команды ```git merge --no-ff```   
12. Разрешите возникший конфликт так, чтобы в результате у вас получилась одна функция с двумя вариантами расчёта факториала, как в показано в примере ниже (подсказка - этот конфликт вам придётся решать вручную)  
```
def factorial(n, method="iterative"):
    if method == "iterative":
        result = 1
        for i in range(1, n + 1):
            result *= i
        return result
    else:
        if n == 0 or n == 1:
            return 1
        else:
            return n * factorial(n - 1, method="recursive")

if __name__ == "__main__":
    number = 5
    method = input("Choose method (iterative/recursive): ").strip().lower()
    print(f"Factorial of {number} is {factorial(number, method)}")
```

13. Закомитьте результат и удалите ветку ***feature/recursive***  
14. Перенесите ветку ***hw25*** на удалённый репозиторий (github) и создайте <u>Pull Request</u>  
15. В классруме прикрепите скриншот вкладки `Files changed` вашего pull request-а.
