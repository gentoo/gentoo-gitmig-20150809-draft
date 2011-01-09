# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/silo/silo-1.4.14.ebuild,v 1.4 2011/01/09 03:25:11 vapier Exp $

inherit mount-boot flag-o-matic toolchain-funcs

DESCRIPTION="SPARC/UltraSPARC Improved Loader, a boot loader for sparc"
SRC_URI="mirror://ubuntu/pool/main/s/${PN}/${PN}_${PV}.orig.tar.gz"

# the sourceforge project is dead. there is no homepage other than gitweb :(
HOMEPAGE="http://git.kernel.org/?p=linux/kernel/git/bcollins/silo.git;a=summary"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* sparc"
IUSE="hardened"

PROVIDE="virtual/bootloader"

DEPEND="sys-fs/e2fsprogs
	sys-apps/sparc-utils"

ABI_ALLOW="sparc32"

src_unpack() {
	unpack ${A}

	cd "${S}"

	# Sanitized headers bug #162537
	epatch "${FILESDIR}"/sanitized-linuxheaders.patch

	epatch "${FILESDIR}"/silo-1.4.x-noglibc_time.patch

	# make it compile with gcc 4.3
	epatch "${FILESDIR}"/gcc-4.3-compile.patch

	# don't strip binaries, let portage handle it!
	epatch "${FILESDIR}"/qa-no-strip.patch

	# Fix build failure
	sed -i -e "s/-fno-strict-aliasing/-fno-strict-aliasing -U_FORTIFY_SOURCE/g" Rules.make

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
	mount-boot_pkg_postinst
	ewarn "NOTE: If this is an upgrade to an existing SILO install,"
	ewarn "      you will need to re-run silo as the /boot/second.b"
	ewarn "      file has changed, else the system will fail to load"
	ewarn "      SILO at the next boot."
}
