#Author Nathaniel Hirsch <nh2@njit.edu>

P=icewm-1.0.8-r4
A=icewm-1.0.8-4.tar.gz
S=${WORKDIR}/icewm-1.0.8
DESCRIPTION="Ice Window Manager"
SRC_URI="prdownloads.sourceforge.net/icewm/${A}"
HOMEPAGE="www.icewm.org"

DEPEND=">=x11-base/xfree-4.0.1"

src_compile(){
	try ./configure --prefix=/usr/X11R6 --sysconfdir=/etc/X11/
	try make
}
src_install(){

	try make prefix=${D}/usr/X11R6 DOCDIR=${S}/dummy install
        dodoc BUGS CHANGES COPYING FAQ PLATFORMS README TODO VERSION
        docinto html
	dodoc doc/*.html
	docinto sgml
	dodoc doc/*.sgml

}

