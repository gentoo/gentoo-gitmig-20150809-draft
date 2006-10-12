# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scanlogd/scanlogd-2.2.6-r1.ebuild,v 1.6 2006/10/12 13:33:56 gustavoz Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Scanlogd - detects and logs TCP port scans"
SRC_URI="http://www.openwall.com/scanlogd/${P}.tar.gz"
HOMEPAGE="http://www.openwall.com/scanlogd/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

DEPEND="virtual/libc"

pkg_setup() {
	enewgroup scanlogd
	enewuser scanlogd -1 -1 /dev/null scanlogd
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-Makefile.patch"
}

src_compile() {
	make CC="$(tc-getCC)" linux || die "make failed"
}

src_install() {
	dosbin scanlogd
	doman scanlogd.8

	newinitd "${FILESDIR}"/scanlogd.rc scanlogd
}

pkg_postinst() {
	einfo "You can start the scanlogd monitoring program at boot by running"
	einfo "rc-update add scanlogd default"
}
