# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upx-ucl/upx-ucl-1.25.ebuild,v 1.1 2004/07/09 01:52:59 matsuu Exp $

MY_P=${P/-ucl/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="upx is the Ultimate Packer for eXecutables."
HOMEPAGE="http://upx.sourceforge.net"
SRC_URI="http://upx.sourceforge.net/download/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

IUSE=""

DEPEND=">=dev-libs/ucl-1.02
	>=dev-lang/perl-5.6
	!app-arch/upx"

src_compile() {
	make -C src UCLDIR=/usr CFLAGS_O="${CFLAGS}" || die "Failed compiling"
	make -C doc || "Failed making documentation"
}

src_install() {
	dobin src/upx

	dodoc BUGS LICENSE LOADER.TXT NEWS PROJECTS README* THANKS doc/upx.doc
	dohtml doc/upx.html
	doman doc/upx.1
}
