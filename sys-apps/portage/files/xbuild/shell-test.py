import shlex
import string
f = open('test.parse')
lex = shlex.shlex(f)
lex.wordchars=string.digits+string.letters+"~!@#$%*_\:;?,./-+{}"
#"+-=><"
lex.quotes=""
token = ' '
while token != '':
	token = lex.get_token()
	print token

