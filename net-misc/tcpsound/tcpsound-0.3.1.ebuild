# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tcpsound/tcpsound-0.3.1.ebuild,v 1.3 2007/10/29 15:36:44 jokey Exp $

inherit eutils

DESCRIPTION="Play sounds in response to network traffic"
HOMEPAGE="http://www.ioplex.com/~miallen/tcpsound/"
SRC_URI="http://www.ioplex.com/~miallen/tcpsound/dl/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="x86"

IUSE=""
DEPEND="net-analyzer/tcpdump
	media-libs/libsdl
	dev-libs/libmba"

src_compile() {
	sed -i -e "s;/usr/share/sounds:/usr/local/share/sounds;/usr/share/tcpsound;g"\
		"${S}"/src/tcpsound.c "${S}"/elaborate.conf

	sed -i -e "s;/share/sounds;/share/tcpsound;g"\
		"${S}"/Makefile
	emake || die "emake failed"
}

src_install() {
	# Makefile expects /usr/bin to be there...
	dodir /usr/bin
	# einstall is required here
	einstall || die

	dodoc README.txt elaborate.conf
}
