class main(package):
	name="sys-libs/glibc-2.1-r1"
	sources="site1,site2/foo.tar.gz site3/bar.tar.gz"
	sites={ "site1":"ftp://ftp.ibiblio.org/pub/linux/utils",
			"site2":"http://www.gentoo.org/patches",
			"site3":"http://foo.bar.com/oni" }
	depend="sys-apps/foo >=sys-apps/bar-1.2"
	rdepend=depend

or...

parent:
	virtual/package
name:	
	sys-libs/glibc-2.1-r1
sources:
	site1,site2/foo.tar.gz
	site3/bar.tar.gz
sites:
	site1 ftp://ftp.ibiblio.org/pub/linux/utils
	site2 http://www.gentoo.org/patches
	site3 http://foo.bar.com/oni
depend:
	sys-apps/foo
	>=sys-apps/bar-1.2
rdepend:
	${depend}
provides:
	virtual/foo-bar-bar-jinks
install:
	cd ${S}/foo
	convert to:
		bashobj.command("cd ${S}/foo") >> bashobj.cd(["/tmp/portage/etc/foo"]) ?
	#features special variable expansion and evaluates special functions as
	#python code
	#OR
	#advanced shell-like syntax
	#python with ` `,${S},cd,etc support? maybe.
	#create a bash object that has its own env settings... then send commands
	#to this bash object for evaluation.
	#will the shell specify strings like "this" or this (bash-style?)	

class bashobj:
	cwd="/"
	env={}
	def command(self,string):
	def cd(self,string):
	def test(self,string):
		[ x -gt 1 ] etc
	def dobin(self,string):
	def dodoc(self,string):
		#what's nice is that these commands can have persistent metainformation
		#that's not stored as environment variables.  Which means more complex
		#metainformation.

		#also, this bash shell program can exist in the same process as xbuild.
		#just make the rest of the xbuild code (except xbuild arg parsing) independent
		#of the os.cwd setting and you're all set.  This object can control cwd.

	#toughest parts are for,while,test,if, recognizing things like && and ||
	#these are also parts of the shell interpreter that could be improved.
	#good array support could be added.
