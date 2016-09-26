package Sept16;

/**
 * Created by Allan on 16-09-16.
 */
public class Main {
    static A a0, a1;

    public static void main(String [] args) {
        a0 = new A();
        a1 = new A();
        a0 = a1;
        a1.i = a1.i + 1;
        out.println("a0.i=%d a1.i=%d\n", a0.i, a1.i);
    }
}


