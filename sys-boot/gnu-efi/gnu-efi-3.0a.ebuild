# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/gnu-efi/gnu-efi-3.0a.ebuild,v 1.1 2004/01/21 17:56:28 agriffis Exp $

DESCRIPTION="Library for build EFI Applications"
SRC_URI="ftp://ftp.hpl.hp.com/pub/linux-ia64/gnu-efi-3.0a.tar.gz"
HOMEPAGE="http://developer.intel.com/technology/efi"

KEYWORDS="~ia64 ~x86"
SLOT="3"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/glibc"	# don't think there's anything else
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} && cd ${S} || die "failed to unpack"
	epatch ${FILESDIR}/gnu-efi-3.0a-lds.patch || die "epatch failed"
}

src_compile() {
	local iarch
	case $ARCH in
		ia64) iarch=ia64 ;;
		x86)  iarch=ia32 ;;
		*)    die "unknown architecture: $ARCH" ;;
	esac
	emake CC="${CC}" ARCH=${iarch} -j1 || die "emake failed"
}

src_install() {
	make install INSTALLROOT=${D} || die "einstall failed"
	dodoc README* ChangeLog
}
