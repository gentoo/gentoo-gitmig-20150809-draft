# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/helium/helium-1.1.ebuild,v 1.13 2004/10/16 23:10:26 axxo Exp $

inherit java-pkg

DESCRIPTION="Helium (for learning Haskell)"
HOMEPAGE="http://www.cs.uu.nl/helium"
SRC_URI="http://www.cs.uu.nl/helium/distr/${P}-src.tar.gz
	 http://www.cs.uu.nl/helium/distr/Hint.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE="readline"

DEPEND="virtual/libc
	virtual/ghc
	readline? ( sys-libs/readline )"
RDEPEND="virtual/libc
	virtual/jdk
	dev-libs/gmp
	readline? ( sys-libs/readline )"

src_unpack() {
	unpack ${P}-src.tar.gz

	# patch for readline support if requested
	if use readline; then
		patch -p0 -i ${FILESDIR}/${P}-readline.patch || die
	fi
	# fix one file due to GHC 6.0's Template Haskell extension
	einfo modifying ParsecPerm to ensure compatibility with GHC 6.0
	cd ${S}/parsec
	mv ParsecPerm.hs ParsecPerm.hs.orig
	sed -e 's/(\$/(\$ /' ParsecPerm.hs.orig > ParsecPerm.hs
}

src_compile() {
	pushd lvm || die
	pushd src || die
	./configure
	popd
	popd
	pushd heliumNT || die
	econf --without-upx || die "econf failed"
	pushd src || die
	make depend || die
	make || die # emake doesn't work safely
}

src_install() {
	cd heliumNT/src || die
	make prefix=${D}/usr \
		bindir=${D}/usr/lib/helium/bin \
		libdir=${D}/usr/lib/helium/lib \
		demodir=${D}/usr/lib/helium/demo \
		install || die
	# install hint
	java-pkg_dojar ${DISTDIR}/Hint.jar
	# create wrappers
	dobin ${FILESDIR}/helium-wrapper
	dosym /usr/bin/helium-wrapper /usr/bin/helium
	dosym /usr/bin/helium-wrapper /usr/bin/lvmrun
	dosym /usr/bin/helium-wrapper /usr/bin/texthint
	dosym /usr/bin/helium-wrapper /usr/bin/hint
}

pkg_postinst() {
	einfo "hi is now called texthint"
	einfo "hint is a new GUI-based interpreter"
}
