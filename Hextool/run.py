import os
import hextool as ht

class MissingEnvVarError(Exception):
    def __init__(self, env):
        Exception.__init__('Environment Variable "%s" not found' % env)

def get_data(env):
    fname = os.environ.get(env)
    if not fname:
        raise MissingEnvVarError(env)

    f = open(fname)
    data = f.read()
    f.close()
    return data

def hex2bin():
    data = get_data('HEX_INFILE')

    ret = ht.hex2bin(data)
    if ret:
        print(ret)

def bin2hex():
    data = get_data('HEX_INFILE')

    ret = ht.bin2hex(data)
    if ret:
        print(ret)

def bin2hexdump():
    data = get_data('HEX_INFILE')

    ret = ht.bin2hexdump(data)
    if ret:
        print(ret)

if __name__ == '__main__':
    mode = os.environ.get('HEXTOOL_MODE')
    if not mode:
        raise MissingEnvVarError('HEXTOOL_MODE')

    if mode == 'hex2bin':
        hex2bin()
    elif mode == 'bin2hex':
        bin2hex()
    elif mode == 'bin2hexdump':
        bin2hexdump
    else:
        raise Exception('Unknown mode "%s"' % mode)
