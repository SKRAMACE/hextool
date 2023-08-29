import os

def hex2bin(s):
    data = str(s)

    # Remove extra characters
    data = data.replace('\n','')
    data = data.replace('0x','')
    data = data.replace('0h','')
    data = data.replace('h','')
    data = data.replace(' ','')

    aline = ''
    for h_ascii in data:
        # Convert hex ascii digit to integer
        h_int = int(h_ascii, 16)

        # Convert to binary ascii
        for shift in range(3,-1,-1):
            b_ascii = (h_int >> shift) & 1
            aline += str(b_ascii)

    return aline

def bin2hex(s):
    data = str(s)

    # Remove extra characters
    data = data.replace('\n','')
    data = data.replace('0b','')
    data = data.replace('b','')

    # Pad with zeros
    if len(data) % 8 > 0:
        z = 8 - (len(data) % 8)
        data = data + '0' * z

    # Group bits into groups of 8
    b = [data[i:i+8] for i in range(0, len(data), 8)]

    aline = ''
    for octet in b:
        aline += '%02x' % int(octet, 2)

    return aline

def bin2hexdump(s):
    data = str(s)

    data = data.replace('\n','')
    b = [int(data[i:i+8],2) for i in range(0, len(data), 8)]

    aline = ''
    for i in range(len(b)):
        # Address
        if i % 16 == 0:
            aline += '%03x ' % i

        aline += '%02x' % b[i]
        if i % 16 == 15:
            print(aline)
            aline = ''
        else:
            aline += ' '

    return aline

def hextool():
    fname = os.environ.get('HEX_INFILE')
