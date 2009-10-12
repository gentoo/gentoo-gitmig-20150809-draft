# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upx-ucl/upx-ucl-1.25-r1.ebuild,v 1.4 2009/10/12 17:06:59 halcy0n Exp $

inherit eutils toolchain-funcs

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

RDEPEND=">=dev-libs/ucl-1.02 !app-arch/upx"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-${PV}-pie.patch

	# used with valgrind
	sed -i -e s/-lmcheck//g src/Makefile.bld || die

	# >=gcc-3.4.x
	if [ "`gcc-major-version`" -ge "3" ] && [ "`gcc-minor-version`" -ge "4" ]; then
		sed -i -e s/-mcpu/-mtune/g src/Makefile.bld || die
	fi
}

src_compile() {
	make -C src UCLDIR=/usr CFLAGS_O="${CFLAGS}" || die "Failed compiling"
	make -C doc || die "Failed making documentation"
}

src_install() {
	dobin src/upx

	dodoc BUGS LOADER.TXT NEWS PROJECTS README* THANKS doc/upx.doc
	dohtml doc/upx.html
	doman doc/upx.1
}
