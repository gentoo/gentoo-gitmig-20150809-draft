# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chroot_safe/chroot_safe-1.3.ebuild,v 1.3 2004/11/24 14:12:32 ka0ttic Exp $

inherit eutils

DESCRIPTION="chroot_safe is a tool to chroot any dynamically linked application in a safe and sane manner."
HOMEPAGE="http://chrootsafe.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf \
		--libexecdir="/usr/$(get_libdir)" \
		--sbindir="/usr/sbin" \
		|| die "econf failed"
	emake CPPFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	dolib.so chroot_safe.so || die "dolib.so failed"
	dosbin chroot_safe || die "dosbin failed"
	dosed "s:/chroot_safe::" /usr/sbin/chroot_safe \
		|| die "dosed chroot_safe failed"
	doman chroot_safe.1 || die "doman failed"
	dodoc CHANGES.txt
}
