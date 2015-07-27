class Sn {
  int n;
  int x[];
  Sn(int nn) {
    n=nn;
    x=new int [nn];
    for (int i=0; i<nn; i++) {
      x[i]=i;
    }
  }
  
  Sn(int nn, int xx[]) {
    n=nn;
    x=new int [nn];
    if (xx.length>=nn) {
      for (int i=0; i<nn; i++) {
        x[i]=xx[i];
      }
    } else {
      for (int i=0; i<nn; i++) {
        x[i]=i;
      }
    }
  }
  
  boolean SnP() {
    int check[]=new int [n];
    for (int i=0; i<n; i++) {
      check[i]=0;
    }
    for (int i=0; i<n; i++) {
      if (0<=x[i] && x[i]<n) {
        check[ x[i] ] ++ ;
      }
    }
    for (int i=0; i<n; i++) {
      if (check[i]!=1) {
        return false;
      }
    }
    return true;
  }
  
  Sn inverse() {
    if (SnP()==false) {
      return new Sn(n);
    }
    int y[]=new int[n];
    for (int i=0; i<n; i++) {
      y[ x[i] ] =i;
    } 
    return new Sn(n, y);
  }
  
  
  Sn prod(Sn b) {
    //サイズが異なる場合にも対応
    int nn=max(b.n, n);
    int xx[]=new int[nn];
    for (int i=0; i<nn; i++) {
      int ai;
      if (n <= i) ai=i; 
      else ai=x[i];
      if (b.n <= ai) xx[i]=ai; 
      else  xx[i]=b.x[ai];
    }
    
    n = nn;
    x = xx;
    return this;
  }
  
  void printP() {
    println(this);
    print("(");
    for (int i=0; i<n; i++) {
      print(" "+i);
    } 
    println(" )");
    print("(");
    for (int i=0; i<n; i++) {
      print(" "+x[i]);
    } 
    println(" )");
  }
  
  void print2() {
    print("(");
    for (int i=0; i<n; i++) {
      print(" "+x[i]);
    } 
    println(" )");
  }
}

Sn id(int n) {
  return new Sn(n);
}

Sn prod(Sn b, Sn a) {
  //サイズが異なる場合にも対応
  int nn = max(b.n, a.n);
  int xx[] = new int[nn];
  for (int i=0; i<nn; i++) {
    int ai;
    if (a.n <= i) {
      ai=i; 
    } else {
      ai=a.x[i];
    }
    if (b.n <= ai) {
      xx[i]=ai; 
    } else {
      xx[i]=b.x[ai];
    }
  }
  return new Sn(nn, xx);
}

Sn exchange(int a, int b) {
  //互換
  int nn=max(a, b)+1;
  int xx[]=new int [nn];
  for (int i=0; i<nn; i++) {
    xx[i]=i;
  }
  xx[a]=b;
  xx[b]=a;
  return new Sn(nn, xx);
}
Sn exchangeNext(int a) {
  //隣接互換
  return exchange(a, a+1);
}
void printDecompose(Sn a, int nn) {
  if (nn==1) {
    println();
    return ;
  } else if (a.n<nn) {
    printDecompose(a, nn-1);
  } else {
    int j=a.x[nn-1];
    print("("+str(j)+" "+str(nn-1)+") ");
    Sn sigma=exchange(j, nn-1);
    Sn b=prod(sigma, a);
    printDecompose(b, nn-1);
  }
}
void printDecompose2(Sn a, int nn) {
  if (nn==1) {
    println();
    return ;
  } else if (a.n<nn) {
    printDecompose2(a, nn-1);
  } else {
    int j=a.x[nn-1];
    Sn b=new Sn(a.n, a.x);
    for (int k=j; k<nn-1; k++) {
      print("("+str(k)+" "+str(k+1)+") ");
      Sn sigma=exchangeNext(k);
      b=prod(sigma, b);
    }
    printDecompose2(b, nn-1);
  }
}

boolean equalP(Sn a, Sn b) {
  //２つの置換が一致するかどうかを返す
  if (a.n<=b.n) {
    for (int i=0; i<a.n; i++) {
      if (a.x[i]!=b.x[i]) return false;
    }
    for (int i=a.n; i<b.n; i++) {
      if (i!=b.x[i]) return false;
    }
  } else if (a.n>b.n) {
    for (int i=0; i<b.n; i++) {
      if (a.x[i]!=b.x[i]) return false;
    }
    for (int i=b.n; i<a.n; i++) {
      if (i!=a.x[i]) return false;
    }
  }
  return true;
}
boolean notIncluded(ArrayList<Sn> g, Sn b) {
  // ArrayListの中に置換bが含まれなければtrueを返す
  int nn=g.size();
  for (int i=0; i<nn; i++) {
    if (equalP(g.get(i), b)) return false;
  }
  return true;
}

void generateGroup(ArrayList<Sn> g, int n) {
  //ArrayListに含まれる置換について、あらゆる積を作ってみてArrayListに追加する
  if (g.size()>n) {
    for (int i=0; i<g.size (); i++) {
      Sn h=prod(g.get(i), g.get(n));
      if (notIncluded(g, h)) {
        g.add(h);
      }
    }
    generateGroup(g, n+1);
  }
}

