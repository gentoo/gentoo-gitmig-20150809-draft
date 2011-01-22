# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/mr/mr-1.02.ebuild,v 1.1 2011/01/22 16:26:54 tove Exp $

DESCRIPTION="Multiple Repository management tool"
HOMEPAGE="http://kitenet.net/~joey/code/mr/"
SRC_URI="mirror://debian/pool/main/m/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	dev-perl/libwww-perl
	dev-perl/HTML-Parser"

S=${WORKDIR}/${PN}

src_install() {
	dobin mr webcheckout || die
	doman mr.1 webcheckout.1 || die
	dodoc README TODO debian/changelog \
		mrconfig mrconfig.complex || die
	insinto /usr/share/${PN}
	doins lib/* || die
}
