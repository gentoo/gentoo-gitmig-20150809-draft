#Author Nathaniel Hirsch <nh2@njit.edu>

A=icewm-1.0.8-6.tar.gz
S=${WORKDIR}/icewm-1.0.8
DESCRIPTION="Ice Window Manager"
SRC_URI="prdownloads.sourceforge.net/icewm/${A}"
HOMEPAGE="www.icewm.org"

DEPEND="virtual/x11"

src_compile(){
	try ./configure --prefix=/usr/X11R6 --sysconfdir=/etc/X11/
	try make
}
src_install(){

	try make prefix=${D}/usr/X11R6 DOCDIR=${S}/dummy install
	exeinto /usr/X11R6/bin/wm
	doexe ${FILESDIR}/icewm
        dodoc BUGS CHANGES COPYING FAQ PLATFORMS README TODO VERSION
        docinto html
	dodoc doc/*.html
	docinto sgml
	dodoc doc/*.sgml

}

