# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc-bin/ghc-bin-5.04.2.ebuild,v 1.1 2002/12/15 06:52:54 george Exp $

IUSE="opengl"

S="${WORKDIR}/ghc-5.04.2"
DESCRIPTION="Glasgow Haskell Compiler"
SRC_URI="http://www.haskell.org/ghc/dist/5.04.2/ghc-5.04.2-i386-unknown-linux.tar.bz2"
HOMEPAGE="http://www.haskell.org"

LICENSE="as-is"
KEYWORDS="~x86 -ppc -sparc -alpha"
SLOT="0"

DEPEND="virtual/glibc"
RDEPEND=">=sys-devel/perl-5.6.1
	>=sys-devel/gcc-2.95.3
	>=dev-libs/gmp-4.1
	opengl? ( virtual/opengl
		virtual/glu
		virtual/glut )"

src_compile() {
	econf || die "./configure failed"
}

src_install () {
	make \
		prefix=${D}/usr \
		datadir=${D}/usr/share \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	# Install documentation.
	dodoc ANNOUNCE INSTALL LICENSE README VERSION

	cd ${D}/usr/share
	mv hslibs.ps users_guide.ps html/ ${D}/usr/share/doc/${PF}
}
