#Author Nathaniel Hirsch <nh2@njit.edu>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/icewm/icewm-1.0.8.6-r1.ebuild,v 1.1 2001/10/12 01:04:39 hallski Exp $


A=icewm-1.0.8-6.tar.gz
S=${WORKDIR}/icewm-1.0.8
DESCRIPTION="Ice Window Manager"
SRC_URI="prdownloads.sourceforge.net/${PN}/${PN}-1.0.8-6.tar.gz"
HOMEPAGE="www.icewm.org"

DEPEND="virtual/x11"

src_compile(){
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc/X11/icewm
	assert

	emake || die
}
src_install(){
	make prefix=${D}/usr						\
	     DOCDIR=${S}/dummy 						\
	     sysconfdir=${D}/etc/X11/icewm				\
	     install || die

        dodoc BUGS CHANGES COPYING FAQ PLATFORMS README TODO VERSION
        docinto html
	dodoc doc/*.html
	docinto sgml
	dodoc doc/*.sgml
}


