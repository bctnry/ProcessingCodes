PVector linesegdiv3_1_2d (PVector a, PVector b) {
  PVector res = new PVector(a.x+(b.x-a.x)/3,a.y+(b.y-a.y)/3);
  return res;
}
PVector linesegdiv3_2_2d (PVector a, PVector b) {
  PVector res = new PVector(a.x+(b.x-a.x)*2/3,
                            a.y+(b.y-a.y)*2/3);
  return res;
}
void kochlize (PVector a, PVector b, int layer) {
  if(layer==1) { line(a.x,-a.y,b.x,-b.y); return ; }
  float len = len(a,b);
  PVector l = linesegdiv3_1_2d(a,b),
          m = upperP(a,b),
          r = linesegdiv3_2_2d(a,b);
  kochlize(a,l,layer-1);
  kochlize(l,m,layer-1);
  kochlize(m,r,layer-1);
  kochlize(r,b,layer-1);
} PVector upperP (PVector a, PVector b) {
    PVector tPoint = linesegdiv3_1_2d(a,b);
    float len = len(a,b);
    float theta = atan((b.y-a.y)/(b.x-a.x)),
          theta_ = radians(degrees(theta)+60);
    // a dirty workaround.
    PVector theta_v =
      (b.x-a.x>0?toUnitVectorR(theta_)
        :negVec2(toUnitVectorR(theta_)));
    PVector res =
      new PVector(tPoint.x+(theta_v.x*len/3),
                  tPoint.y+(theta_v.y*len/3));
    return res;
  } float len (PVector a, PVector b) {
      return sqrt(pow((a.x-b.x),2)+pow((a.y-b.y),2));
    }
    PVector toUnitVectorR (float r) {
      return new PVector(cos(r),sin(r));
    }
    PVector negVec2 (PVector a) {
      return new PVector(-a.x,-a.y);
    }

void setup() {
  background(0);
  size(600,600);
  stroke(255);
}
void draw() {
  translate(0,height);
  PVector A = new PVector(200,200),
          B = new PVector(400,200),
          C = new PVector(300,sqrt(3)*100+200);
  int layerNum = 4;
  kochlize(A,C,layerNum);
  kochlize(C,B,layerNum);
  kochlize(B,A,layerNum);
}
  
