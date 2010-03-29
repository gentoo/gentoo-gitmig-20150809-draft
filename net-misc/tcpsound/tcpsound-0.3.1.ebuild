# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tcpsound/tcpsound-0.3.1.ebuild,v 1.4 2010/03/29 12:20:07 ssuominen Exp $

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

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
}

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
