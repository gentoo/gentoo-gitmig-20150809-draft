# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/x86info/x86info-1.13.ebuild,v 1.2 2005/08/24 00:29:03 vapier Exp $

inherit eutils

DESCRIPTION="Dave Jones' handy, informative x86 CPU diagnostic utility"
HOMEPAGE="http://www.codemonkey.org.uk/projects/x86info/"
SRC_URI="http://www.codemonkey.org.uk/projects/x86info/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/1.12b-pic.patch
}

src_compile() {
	emake x86info CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	# binaries first
	dobin x86info

	# modules stuff next
	insinto /etc/modules.d
	newins ${FILESDIR}/x86info-modules.conf-rc x86info

	# now we all all the docs
	dodoc TODO README ChangeLog
	doman x86info.1
	cp -pPR results ${D}/usr/share/doc/${PF}
	prepalldocs
}

pkg_postinst() {
	ewarn "Your kernel must be built with the following options"
	ewarn "set to Y or M"
	ewarn "     Processor type and features ->"
	ewarn "         [*] /dev/cpu/*/msr - Model-specific register support"
	ewarn "         [*] /dev/cpu/*/cpuid - CPU information support"
}
