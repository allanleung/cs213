package arch.sm213.machine.student;
import machine.AbstractMainMemory.*;

import org.junit.Before;
import org.junit.Test;
import sun.applet.Main;

import static org.junit.Assert.*;

/**
 * Created by Allan on 16-09-21.
 */
public class MainMemoryTest {
    private MainMemory mainMemory;

    @Before
    public void runBefore() {
        mainMemory = new MainMemory(1024);
    }
    @Test
    public void testIsAccessAligned() throws Exception {
        assertEquals(true, mainMemory.isAccessAligned(0,2));
        assertEquals(false, mainMemory.isAccessAligned(1,2));
        assertEquals(true, mainMemory.isAccessAligned(2,2));
        assertEquals(false, mainMemory.isAccessAligned(3,2));
        assertEquals(true, mainMemory.isAccessAligned(4,2));
    }

    @Test
    public void testBytesToInteger() throws Exception {
        assertEquals(mainMemory.bytesToInteger((byte)0, (byte)0, (byte)0, (byte)0), 0);
        assertEquals(mainMemory.bytesToInteger((byte)0, (byte)0, (byte)0, (byte)1), 1);
        assertEquals(mainMemory.bytesToInteger((byte)0, (byte)0, (byte)0, (byte)0xff), 255);
        assertEquals(mainMemory.bytesToInteger((byte)0xff, (byte)0, (byte)0, (byte)0), -16777216);
        assertEquals(mainMemory.bytesToInteger((byte)0, (byte)0, (byte)0, (byte)0x80), 128);
        assertEquals(mainMemory.bytesToInteger((byte)0x80, (byte)0, (byte)0, (byte)0), -2147483648);
    }

    @Test
    public void testIntegerToBytes() throws Exception {
        byte[] results = mainMemory.integerToBytes(0x00000000);
        assertEquals((byte)0, results[0]);
        assertEquals((byte)0, results[1]);
        assertEquals((byte)0, results[2]);
        assertEquals((byte)0, results[3]);

    }
    @Test
    public void testIntegerToBytes2() throws Exception {
        byte[] results = mainMemory.integerToBytes(0xFFFFFFFF);
        assertEquals((byte)-1, results[0]);
        assertEquals((byte)-1, results[1]);
        assertEquals((byte)-1, results[2]);
        assertEquals((byte)-1, results[3]);
    }
    @Test
    public void testIntegerToBytesRandom() throws Exception {
        byte[] results = mainMemory.integerToBytes(256);
        assertEquals((byte)00, results[0]);
        assertEquals((byte)00, results[1]);
        assertEquals((byte)01, results[2]);
        assertEquals((byte)00, results[3]);
    }
    @Test
    public void testIntegerToBytesRandom3() throws Exception {
        byte[] results = mainMemory.integerToBytes(-256);
        assertEquals((byte)0xFF, results[0]);
        assertEquals((byte)0xFF, results[1]);
        assertEquals((byte)0xFF, results[2]);
        assertEquals((byte)0x00, results[3]);
    }

    @Test
    public void testIntegerToBytesRandom2() throws Exception {
        byte[] results = mainMemory.integerToBytes(0x0102C834);
        assertEquals((byte)0x01, results[0]);
        assertEquals((byte)0x02, results[1]);
        assertEquals((byte)0xC8, results[2]);
        assertEquals((byte)0x34, results[3]);
    }

    @Test
    public void testGetAndSet() throws Exception {
        byte[] results = mainMemory.integerToBytes(0x01020304);
        mainMemory.set(0, results);
        byte [] actual = mainMemory.get(0,8);
        for (int i = 0; i < results.length; i++) {
            assertEquals(results[i], actual[i]);
        }
    }
    @Test(expected = InvalidAddressException.class)
    public void testGetAndSetFail() throws Exception {
        byte[] results = mainMemory.integerToBytes(0x01020304);
        mainMemory.set(2000,results);
    }

    @Test(expected = InvalidAddressException.class)
    public void testGetAndSetFailNegative() throws Exception{
        byte[] results = mainMemory.integerToBytes(0x01020304);
        mainMemory.set(-2000,results);
    }

    @Test(expected = InvalidAddressException.class)
    public void testGetFailInvalidAddress() throws Exception {
        //byte[] results = mainMemory.integerToBytes(0x01020304);
        mainMemory.get(-2000, 8);
    }

    @Test(expected = InvalidAddressException.class)
    public void testGetFailInvalidAddress2() throws Exception {
        //byte[] results = mainMemory.integerToBytes(0x01020304);
        mainMemory.get(2000, 80);
    }
}