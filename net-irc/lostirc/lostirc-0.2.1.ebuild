# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/lostirc/lostirc-0.2.1.ebuild,v 1.4 2003/07/13 12:43:38 mholzer Exp $

IUSE=""

DESCRIPTION="A simple but functional graphical IRC client"
HOMEPAGE="http://lostirc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=dev-cpp/gtkmm-2.0*
	=dev-libs/libsigc++-1.2*"


S=${WORKDIR}/${P}

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die

	emake || die

}

src_install () {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	rm ${D}/usr/share/gnome -fr

	dodoc AUTHORS ChangeLog COPYING INSTALL README TODO

}
