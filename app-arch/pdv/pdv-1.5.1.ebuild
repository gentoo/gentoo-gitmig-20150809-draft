# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pdv/pdv-1.5.1.ebuild,v 1.1 2003/07/07 13:39:01 vapier Exp $

DESCRIPTION="build a self-extracting and self-installing binary package"
HOMEPAGE="http://pdv.sourceforge.net/"
SRC_URI="mirror://sourceforge/pdv/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="X"

DEPEND="X? ( virtual/x11 )"

src_compile() {
	local myconf=""
	use X || myconf="--without-x" # configure script is broken, cant use use_with
	econf ${myconf} || die
	emake || die
}

src_install() {
	dobin pdv pdvmkpkg || die
	use X && dobin X11/xmpdvmkpkg || die
	doman pdv.1 pdvmkpkg.1
	use X && doman xmpdvmkpkg.1
	dodoc AUTHORS ChangeLog INSTALL NEWS README pdv.lsm
}
