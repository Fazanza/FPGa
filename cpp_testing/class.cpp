#include <iostream>

using namespace std;

class parent {
  private:
    int real, imag;

  public:
    parent(int real= 0, int imag = 0) {
      this->real = real;
      this->imag = imag;
    }

    void func(int x) {
      cout << "value of x is " << x << endl;
    }

    // Example of function overloading (different type)
    void func(double x) {
      cout << "value of x is " << x << endl;
    }

    // Example of function overloading (multiple parameters)
    void func(int x, int y) {
      cout << "value of x and y are " << x << " " << y << endl;
    }

    // Operator overloading
    parent operator+(parent const& obj) {
      parent res;
      res.real = real + obj.real;
      res.imag = imag + obj.imag;
      return res;
    }
};

class screen {
  public:
    virtual void display() {
      cout << "Called virtual base class display" << endl;
    }

    void print() {
      cout << "called base class print function" << endl;
    }
};

class monitor : public screen {
  public:
    void display() {
      cout << "Called child class display" << endl;
    }

    void print() {
      cout << "called derived class print function" << endl;
    }
};

int main() {
  screen* p;
  monitor c;
  p = &c;
  p->display();
  p->print();
  return 0;
}