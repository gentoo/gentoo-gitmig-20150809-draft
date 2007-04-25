# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnopaster/gnopaster-0.0.6.ebuild,v 1.4 2007/04/25 21:37:14 jurek Exp $

DESCRIPTION="A submitter for gnopaste, a nopaste service like http://nopaste.info"
HOMEPAGE="http://gnopaste.sf.net"
SRC_URI="mirror://sourceforge/gnopaste/${P}.pl.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/libwww-perl
	dev-perl/Config-Simple"

src_install() {
	dobin ${WORKDIR}/${P}.pl
	dosym ${P}.pl /usr/bin/${PN}
}
