# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpufreqd/cpufreqd-1.2.2.ebuild,v 1.1 2005/01/29 11:41:13 brix Exp $

inherit flag-o-matic

DESCRIPTION="Daemon to adjust CPU frequency for power saving"

HOMEPAGE="http://cpufreqd.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

src_compile() {
	# cpufreqd segfaults when built as PIE
	filter-flags "-fpie" "-fPIE" "-Wl,-pie"

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"

	doinitd scripts/gentoo/cpufreqd

	dodoc AUTHORS ChangeLog README TODO
}
