# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/lostirc/lostirc-0.1.0.ebuild,v 1.5 2002/07/17 07:36:02 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A simple but functional graphical IRC client"
HOMEPAGE="http://lostirc.sourceforge.net/"
SRC_URI="mirror://sourceforge/lostirc/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND="=x11-libs/gtkmm-1.2.9*
	>=dev-libs/libsigc++-1.0.4*"


src_compile() {

	econf || die

	emake || die

}

src_install () {

#	make \
#		prefix=${D}/usr \
#		datadir=${D}/usr/share \
#		mandir=${D}/usr/share/man \
#		infodir=${D}/usr/share/info \
#		install || die

	make DESTDIR=${D} install || die
	rm ${D}/usr/share/gnome -fr

	dodoc AUTHORS ChangeLog COPYING INSTALL README TODO

}
