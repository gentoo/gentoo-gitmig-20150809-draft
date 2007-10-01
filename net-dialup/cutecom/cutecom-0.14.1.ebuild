# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/cutecom/cutecom-0.14.1.ebuild,v 1.4 2007/10/01 11:52:11 mrness Exp $

inherit eutils qt3

DESCRIPTION="CuteCom is a serial terminal, like minicom, written in qt"
HOMEPAGE="http://cutecom.sourceforge.net"
SRC_URI="http://cutecom.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="$(qt_min_version 3.2)"
RDEPEND="${DEPEND}
	net-dialup/lrzsz"

src_compile() {
	eqmake3 || die "eqmake3 failed"
	emake || die "emake failed"

	# clean qt lock file
	local f
	for f in "${QTDIR}"/etc/settings/.qt_plugins*.lock; do
		rm -f "${f}"
	done
}

src_install() {
	dobin cutecom || die "failed to install cutecom bin"
	dodoc README Changelog README

	make_desktop_entry cutecom "CuteCom" openterm
}
