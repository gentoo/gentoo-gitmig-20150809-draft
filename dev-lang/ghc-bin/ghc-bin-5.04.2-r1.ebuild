# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc-bin/ghc-bin-5.04.2-r1.ebuild,v 1.1 2003/05/09 09:41:39 kosmikus Exp $

IUSE="opengl"

S="${WORKDIR}/ghc-${PV}"
DESCRIPTION="Glasgow Haskell Compiler"
SRC_URI="x86? ( http://www.haskell.org/ghc/dist/${PV}/ghc-${PV}-i386-unknown-linux.tar.bz2 )
	sparc? ( http://www.haskell.org/ghc/dist/${PV}/ghc-${PV}-sparc-sun-solaris2.tar.bz2 )"
HOMEPAGE="http://www.haskell.org"

LICENSE="as-is"
KEYWORDS="~x86 -ppc ~sparc -alpha"
SLOT="0"

LOC="/opt/ghc"

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
		prefix=${D}${LOC} \
		datadir=${D}${LOC}/share \
		mandir=${D}${LOC}/share/man \
		infodir=${D}${LOC}/share/info \
		install || die

	# Install documentation.
	dodoc ANNOUNCE INSTALL LICENSE README VERSION

	cd ${D}${LOC}/share
	mkdir ${D}${LOC}/doc/${PF}
	mv hslibs.ps users_guide.ps html/ ${D}${LOC}/doc/${PF}

	#ghc seems to set locations in wrapper scripts from make install
	#need to strip the ${D} part out
	cd ${D}${LOC}/bin
	mv ghc-${PV} ghc-${PV}-orig
	sed -e "s:${D}::" ghc-${PV}-orig > ghc-${PV}
	mv ghci-${PV} ghci-${PV}-orig
	sed -e "s:${D}::" ghci-${PV}-orig > ghci-${PV}
	mv ghc-pkg-${PV} ghc-pkg-${PV}-orig
	sed -e "s:${D}::" ghc-pkg-${PV}-orig > ghc-pkg-${PV}
	rm ghc-${PV}-orig ghci-${PV}-orig ghc-pkg-${PV}-orig
	chmod a+x ghc-${PV} ghci-${PV} ghc-pkg-${PV}

	insinto /etc/env.d
	doins ${FILESDIR}/10ghc
}
