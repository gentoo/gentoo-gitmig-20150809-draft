# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/gnu-efi/gnu-efi-3.0e.ebuild,v 1.1 2008/02/08 17:36:43 armin76 Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Library for build EFI Applications"
HOMEPAGE="http://developer.intel.com/technology/efi"
SRC_URI="mirror://sourceforge/gnu-efi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE=""

DEPEND="sys-apps/pciutils"

S="${WORKDIR}"/${PN}-3.0

src_compile() {
	local iarch
	case $ARCH in
		ia64) iarch=ia64 ;;
		x86)  iarch=ia32 ;;
		*)    die "unknown architecture: $ARCH" ;;
	esac
	emake CC="$(tc-getCC)" ARCH=${iarch} -j1 || die "emake failed"
}

src_install() {
	make install INSTALLROOT="${D}"/usr || die "install failed"
	dodoc README* ChangeLog
}
