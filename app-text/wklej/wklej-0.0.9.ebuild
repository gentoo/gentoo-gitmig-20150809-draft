# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wklej/wklej-0.0.9.ebuild,v 1.1 2007/08/19 00:45:44 jurek Exp $

DESCRIPTION="a wklej.org submitter"
HOMEPAGE="http://wklej.org"
SRC_URI="http://wklej.org/apps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
		dev-perl/libwww-perl
		dev-perl/Config-Simple"
RDEPEND="${DEPEND}"

src_install() {
	dobin ${WORKDIR}/${P}.pl
	dosym ${P}.pl /usr/bin/${PN}
}
