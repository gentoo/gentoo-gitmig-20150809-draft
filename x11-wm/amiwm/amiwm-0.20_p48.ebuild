# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/amiwm/amiwm-0.20_p48.ebuild,v 1.1 2003/09/06 17:17:40 karltk Exp $

MY_P="${PN}${PV/_p/pl}"
DESCRIPTION="Windowmanager ala Amiga® Workbenh"
HOMEPAGE="http://www.lysator.liu.se/~marcus/amiwm.html"
SRC_URI="ftp://ftp.lysator.liu.se/pub/X11/wm/amiwm/${MY_P}.tar.gz"

LICENSE="amiwm"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/x11"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dodir /usr/bin
	einstall

#	make \
#		prefix=${D}/usr \
#		mandir=${D}/usr/share/man \
#		install || die

	rm ${D}/usr/bin/requestchoice
	dosym /usr/lib/amiwm/requestchoice /usr/bin/requestchoice

	dosed /usr/lib/amiwm/{Xinitrc,Xsession,Xsession2}

	dodoc INSTALL README*

	exeinto /etc/X11/Sessions
	echo "/usr/bin/amiwm" > ${T}/amiwm
	doexe ${T}/amiwm
}
