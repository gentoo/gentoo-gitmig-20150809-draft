# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ghc-bin/ghc-bin-6.2.2.ebuild,v 1.2 2004/12/09 15:18:21 chriswhite Exp $

IUSE="" # opengl not included in binary

S="${WORKDIR}/ghc-${PV}"
DESCRIPTION="Glasgow Haskell Compiler"
SRC_URI="x86? ( http://www.haskell.org/ghc/dist/${PV}/ghc-${PV}-i386-unknown-linux.tar.bz2  )"
HOMEPAGE="http://www.haskell.org"

LICENSE="as-is"
KEYWORDS="~x86 -ppc -sparc -alpha"
SLOT="0"

LOC="/opt/ghc"

DEPEND="virtual/libc"
RDEPEND=">=dev-lang/perl-5.6.1
	>=sys-devel/gcc-2.95.3
	>=dev-libs/gmp-4.1"

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
	mv hslibs.ps users_guide.ps html ${D}/usr/share/doc/${PF}

	#ghc seems to set locations in wrapper scripts from make install
	#need to strip the ${D} part out
	cd ${D}${LOC}/bin
	clean_wrappers ghc-${PV} ghci-${PV} ghc-pkg-${PV} hsc2hs

	insinto /etc/env.d
	doins ${FILESDIR}/10ghc
}

clean_wrappers() {
	for i in $*; do
		mv ${i} ${i}-orig
		sed -e "s:${D}::" ${i}-orig > ${i}
		chmod a+x ${i}
		rm ${i}-orig
	done
}
