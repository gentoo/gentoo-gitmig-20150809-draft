# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/sendxmpp/sendxmpp-0.0.5.ebuild,v 1.1 2004/12/03 15:40:55 rizzo Exp $

inherit eutils
DESCRIPTION="sendxmpp is a perl-script to send xmpp (jabber), similar to what mail(1) does for mail."
HOMEPAGE="http://www.djcbsoftware.nl/code/sendxmpp/"
SRC_URI="http://www.djcbsoftware.nl/code/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
#RESTRICT="nostrip"
DEPEND="dev-perl/Net-XMPP"
#RDEPEND=""

#S=${WORKDIR}/${P}

src_compile() {
	perl Makefile.PL \
		PREFIX=/usr DESTDIR=${D}

	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc Changes README INSTALL
}
