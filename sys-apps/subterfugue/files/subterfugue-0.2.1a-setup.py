from distutils.core import setup, Extension

ptracemodule = Extension("ptrace", sources = ['modules/ptracemodule.c'])
linuxmodule = Extension("linux", sources = ['modules/linuxmodule.c'])
svr4module = Extension("svr4", sources = ['modules/svr4module.c'])
_subterfuguemodule = Extension("_subterfugue", sources= ['modules/_subterfuguemodule.c'])

setup (name = 'ptrace',
       ext_modules = [ptracemodule, linuxmodule, svr4module, _subterfuguemodule])
       
