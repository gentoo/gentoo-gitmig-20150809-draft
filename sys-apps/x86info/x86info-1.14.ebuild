# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/x86info/x86info-1.14.ebuild,v 1.1 2005/08/24 00:33:45 vapier Exp $

inherit eutils

DESCRIPTION="Dave Jones' handy, informative x86 CPU diagnostic utility"
HOMEPAGE="http://www.codemonkey.org.uk/projects/x86info/"
SRC_URI="http://www.codemonkey.org.uk/projects/x86info/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/1.12b-pic.patch
}

src_compile() {
	emake x86info CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin x86info || die

	insinto /etc/modules.d
	newins "${FILESDIR}"/x86info-modules.conf-rc x86info

	dodoc TODO README ChangeLog
	doman x86info.1
	insinto /usr/share/doc/${PF}
	doins -r results
	prepalldocs
}

pkg_postinst() {
	ewarn "Your kernel must be built with the following options"
	ewarn "set to Y or M"
	ewarn "     Processor type and features ->"
	ewarn "         [*] /dev/cpu/*/msr - Model-specific register support"
	ewarn "         [*] /dev/cpu/*/cpuid - CPU information support"
}
