# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc-bin/ghc-bin-5.04.2.ebuild,v 1.7 2003/08/05 18:55:56 vapier Exp $

IUSE="opengl"

S="${WORKDIR}/ghc-5.04.2"
DESCRIPTION="Glasgow Haskell Compiler"
SRC_URI="x86? ( http://www.haskell.org/ghc/dist/${PV}/ghc-${PV}-i386-unknown-linux.tar.bz2 )
	sparc? ( http://www.haskell.org/ghc/dist/${PV}/ghc-${PV}-sparc-sun-solaris2.tar.bz2 )"
HOMEPAGE="http://www.haskell.org"

LICENSE="as-is"
KEYWORDS="x86 -ppc ~sparc -alpha"
SLOT="0"

DEPEND="virtual/glibc"
RDEPEND=">=dev-lang/perl-5.6.1
	>=sys-devel/gcc-2.95.3
	>=dev-libs/gmp-4.1
	opengl? ( virtual/opengl
		virtual/glu
		virtual/glut )"

PROVIDE="virtual/ghc"

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

	#ghc seems to set locations in wrapper scripts from make install
	#need to strip the ${D} part out
	cd ${D}/usr/bin
	mv ghc-5.04.2 ghc-5.04.2-orig
	sed -e "s:${D}::" ghc-5.04.2-orig > ghc-5.04.2
	mv ghci-5.04.2 ghci-5.04.2-orig
	sed -e "s:${D}::" ghci-5.04.2-orig > ghci-5.04.2
	mv ghc-pkg-5.04.2 ghc-pkg-5.04.2-orig
	sed -e "s:${D}::" ghc-pkg-5.04.2-orig > ghc-pkg-5.04.2
	rm ghc-5.04.2-orig ghci-5.04.2-orig ghc-pkg-5.04.2-orig
	chmod a+x ghc-5.04.2 ghci-5.04.2 ghc-pkg-5.04.2
}
