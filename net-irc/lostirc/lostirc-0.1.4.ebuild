# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/lostirc/lostirc-0.1.4.ebuild,v 1.1 2002/07/13 17:03:03 stroke Exp $

DESCRIPTION="A simple but functional graphical IRC client"
HOMEPAGE="http://lostirc.sourceforge.net/"
LICENSE="GPL-2"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/lostirc/${P}.tar.gz
	http://telia.dl.sourceforge.net/sourceforge/lostirc/${P}.tar.gz
	http://belnet.dl.sourceforge.net/sourceforge/lostirc/${P}.tar.gz"

SLOT="0"
KEYWORDS="*"

DEPEND="( >=x11-libs/gtkmm-1.2.9-r1
	  <x11-libs/gtkmm-1.3.0 )
	( >=dev-libs/libsigc++-1.0.4-r1
	  <dev-libs/libsigc++-1.1.0 )"

RDEPEND="${DEPEND}"

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
