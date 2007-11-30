# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/webfuzzer/webfuzzer-0.2.0.ebuild,v 1.2 2007/11/30 14:35:02 coldwind Exp $

inherit eutils

DESCRIPTION="Poor man's web vulnerability scanner"
HOMEPAGE="http://gunzip.altervista.org/g.php?f=projects"
SRC_URI="http://gunzip.altervista.org/webfuzzer/webfuzzer-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/devel

src_install() {
	dodoc CHANGES README TODO
	dobin webfuzzer
}
