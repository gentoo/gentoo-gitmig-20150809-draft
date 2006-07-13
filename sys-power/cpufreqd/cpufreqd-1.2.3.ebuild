# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/cpufreqd/cpufreqd-1.2.3.ebuild,v 1.5 2006/07/13 18:59:16 phreak Exp $

inherit flag-o-matic

DESCRIPTION="Daemon to adjust CPU frequency for power saving"
HOMEPAGE="http://cpufreqd.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

IUSE=""

src_compile() {
	# cpufreqd segfaults when built as PIE
	filter-flags "-fpie" "-fPIE" "-Wl,-pie"

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	doinitd "${S}"/scripts/gentoo/cpufreqd

	dodoc AUTHORS ChangeLog README TODO
}
