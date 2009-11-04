# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/x86info/x86info-1.25.ebuild,v 1.1 2009/11/04 05:21:18 robbat2 Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Dave Jones' handy, informative x86 CPU diagnostic utility"
HOMEPAGE="http://www.codemonkey.org.uk/projects/x86info/"
SRC_URI="http://www.codemonkey.org.uk/projects/x86info/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="sys-apps/sed" # used in the makefile

src_prepare() {
	epatch "${FILESDIR}"/1.21-pic.patch
	epatch "${FILESDIR}"/${PN}-1.24-pic.patch #270388
	epatch "${FILESDIR}"/${PN}-1.25-parallel-make-cleanup.patch
}

src_compile() {
	emake deps \
		|| die "emake deps failed"
	emake x86info lsmsr \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} ${CPPFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dobin x86info lsmsr || die

	insinto /etc/modprobe.d
	newins "${FILESDIR}"/x86info-modules.conf-rc x86info.conf

	dodoc TODO README
	doman x86info.1 lsmsr.8
	insinto /usr/share/doc/${PF}
	doins -r results
	prepalldocs
}

pkg_preinst() {
	if [ -a "${ROOT}"/etc/modules.d/x86info ] && [ ! -a "${ROOT}"/etc/modprobe.d/x86info ] ; then
		elog "Moving x86info from /etc/modules.d/ to /etc/modprobe.d/"
		mv "${ROOT}"/etc/{modules,modprobe}.d/x86info
	fi
	if [ -a "${ROOT}"/etc/modprobe.d/x86info ] && [ ! -a "${ROOT}"/etc/modprobe.d/x86info.conf ] ; then
		elog "Adding .conf suffix to x86info in /etc/modprobe.d/"
		mv "${ROOT}"/etc/modprobe.d/x86info{,.conf}
	fi
}

pkg_postinst() {
	ewarn "Your kernel must be built with the following options"
	ewarn "set to Y or M"
	ewarn "     Processor type and features ->"
	ewarn "         [*] /dev/cpu/*/msr - Model-specific register support"
	ewarn "         [*] /dev/cpu/*/cpuid - CPU information support"
}
