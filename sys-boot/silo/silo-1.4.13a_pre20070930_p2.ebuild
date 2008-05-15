# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/silo/silo-1.4.13a_pre20070930_p2.ebuild,v 1.1 2008/05/15 15:00:51 armin76 Exp $

inherit mount-boot flag-o-matic toolchain-funcs

DEB_PL="${P##*_p}"
MY_PV="${PV##*_pre}"
MY_GIT="git${MY_PV%%_*}"
MY_PV="${PV%%_*}"
MY_P="${PN}_${MY_PV}+${MY_GIT}"

DESCRIPTION="SPARC/UltraSPARC Improved Loader, a boot loader for sparc"
SRC_URI="mirror://debian/pool/main/s/${PN}/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/s/${PN}/${MY_P}-${DEB_PL}.diff.gz"
HOMEPAGE="http://www.sparc-boot.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~sparc"
IUSE="hardened"

PROVIDE="virtual/bootloader"

DEPEND="sys-fs/e2fsprogs
	sys-apps/sparc-utils"

ABI_ALLOW="sparc32"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}

	epatch ${MY_P}-${DEB_PL}.diff

	cd "${S}"
	epatch "${WORKDIR}"/${MY_P/_/-}/debian/patches/*.patch
	epatch "${FILESDIR}"/sanitized-linuxheaders.patch

	#Set the correct version
	sed -i -e "s/1.4.13/1.4.13_git20070830_p2/g" Rules.make
}

src_compile() {
	filter-flags "-fstack-protector"

	if use hardened
	then
		make ${MAKEOPTS} CC="$(tc-getCC) -fno-stack-protector -fno-pic"
	else
		make ${MAKEOPTS} CC="$(tc-getCC)" || die
	fi
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc first-isofs/README.SILO_ISOFS docs/README*

	# Fix maketilo manpage
	rm "${D}"/usr/share/man/man1/maketilo.1
	dosym /usr/share/man/man1/tilo.1 /usr/share/man/man1/maketilo.1
}

pkg_postinst() {
	ewarn "NOTE: If this is an upgrade to an existing SILO install,"
	ewarn "      you will need to re-run silo as the /boot/second.b"
	ewarn "      file has changed, else the system will fail to load"
	ewarn "      SILO at the next boot."
}
