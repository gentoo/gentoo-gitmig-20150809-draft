# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/yaboot/yaboot-1.3.13.ebuild,v 1.1 2004/11/05 04:16:30 dostrow Exp $

inherit eutils toolchain-funcs

DESCRIPTION="PPC Bootloader"
SRC_URI="http://penguinppc.org/projects/yaboot/${P}.tar.gz"
HOMEPAGE="http://penguinppc.org/projects/yaboot/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc -x86 -amd64 -alpha -hppa -mips -sparc -ppc64"
IUSE=""

DEPEND="sys-apps/powerpc-utils
	sys-fs/hfsutils
	sys-fs/hfsplusutils"

PROVIDE="virtual/bootloader"

MAKEOPTS='PREFIX=/usr MANDIR=share/man'

pkg_setup() {
	case "$(uname -r)" in
		2.5.*|2.6.0*|2.6.1|2.6.1-*|2.6.2|2.6.2-*)
		eerror "You are running Linux kernel `uname -r` which is not supported"
		eerror "Please note if you are running a 2.6 kernel the verison"
		eerror "of ofpath included in this revision of yaboot requires"
		eerror "that you run a kernel >= 2.6.3."
		die
		;;
	esac
}

src_compile() {
	export -n CFLAGS
	export -n CXXFLAGS
	[ -n "$(tc-getCC)" ] || CC="gcc"
	# dual boot patch
	epatch ${FILESDIR}/yabootconfig-${PV}.patch
	epatch ${FILESDIR}/chrpfix.patch
	epatch ${FILESDIR}/yaboot-3.4.patch
	epatch ${FILESDIR}/yaboot-${PV}-ofpath.patch
	emake ${MAKEOPTS} CC="$(tc-getCC)" || die
}

src_install() {
	cp etc/yaboot.conf etc/yaboot.conf.bak
	sed -e 's/\/local//' etc/yaboot.conf >| etc/yaboot.conf.edit
	mv -f etc/yaboot.conf.edit etc/yaboot.conf
	make ROOT=${D} ${MAKEOPTS} install || die
}

pkg_postinst() {
	ewarn "Please note if you are running a 2.6 kernel the verison"
	ewarn "of ofpath included in this revision of yaboot requires"
	ewarn "that you run a kernel >= 2.6.3 Prior versions are unsupported."
}
