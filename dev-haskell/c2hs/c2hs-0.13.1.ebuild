# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/c2hs/c2hs-0.13.1.ebuild,v 1.2 2004/08/24 09:25:33 kosmikus Exp $

DESCRIPTION="An interface generator for Haskell"
HOMEPAGE="http://www.cse.unsw.edu.au/~chak/haskell/c2hs/"
SRC_URI="http://www.cse.unsw.edu.au/~chak/haskell/c2hs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

inherit base

KEYWORDS="~x86"

IUSE=""

DEPEND=">=virtual/ghc-6.2"

src_unpack() {
	base_src_unpack
	# package config file apparently missing haskell98 dependency
	sed -i "s:lang\":lang\",\"haskell98\":" ${S}/c2hs/c2hs.conf.in
}

src_compile() {
	econf --disable-add-package || die "configure failed"
	# tested emake; doesn't work
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

pkg_postinst() {
	einfo "Registering c2hs package"
	/usr/bin/c2hs-config --package-conf \
		| ghc-pkg -u --auto-ghci-libs
}

pkg_postrm() {
	# check if another version is still there
	has_version "<${CATEGORY}/${PF}" \
		|| has_version ">${CATEGORY}/${PF}" \
		|| unregister_ghc_packages
}

unregister_ghc_packages() {
	einfo "Unregistering c2hs package"
	/usr/bin/ghc-pkg -r c2hs
}

