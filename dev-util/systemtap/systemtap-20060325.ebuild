# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/systemtap/systemtap-20060325.ebuild,v 1.1 2006/03/27 04:53:44 zx Exp $

inherit kernel-mod

DESCRIPTION="A linux trace/probe tool"
HOMEPAGE="http://sourceware.org/systemtap/"
SRC_URI="ftp://sourceware.org/pub/$PN/snapshots/${P}.tar.bz2"
S="${WORKDIR}/src"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/linux-sources-2.6.9
	>=dev-libs/elfutils-0.116"

pkg_setup() {
	if ! kernel-mod_configoption_builtin KPROBES; then
		einfo "systemtap needs CONFIG_KPROBES in the kernel"
		einfo "enable it under Kernel hacking -> Kprobes."
		die "CONFIG_KPROBES not present"
	fi
	if ! kernel-mod_configoption_present RELAYFS_FS; then
		einfo "systemtap needs CONFIG_RELAYFS_FS in the kernel"
		einfo "enable it under Filesystems -> Pseudo filesystems -> Relayfs."
		die "CONFIG_RELAYFS_FS not present"
	fi
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	keepdir /var/cache/systemtap
	dodoc AUTHORS ChangeLog HACKING NEWS README
}

src_test() {
	make check || die "make check failed"
}
