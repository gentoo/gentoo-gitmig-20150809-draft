# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hsshellscript/hsshellscript-2.1.0.ebuild,v 1.2 2005/03/04 03:16:13 araujo Exp $

inherit base eutils ghc-package

DESCRIPTION="A Haskell library for UNIX shell scripting tasks"
HOMEPAGE="http://www.volker-wysk.de/hsshellscript/"
SRC_URI="http://www.volker-wysk.de/hsshellscript/dist/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=">=virtual/ghc-6.2
		doc? ( >=dev-haskell/haddock-0.6-r2 )"
RDEPEND=">=virtual/ghc-6.2"


src_unpack() {
	base_src_unpack
	cd ${S}
	sed -i -e "/ghc-pkg/d" Makefile
}

src_compile() {
	emake || die "emake failed"

	if use doc; then
		emake doc || die "make doc failed"
	fi
}

src_install() {
	sed -i "s:\${DEST_LIB}:$(ghc-libdir):" \
		${S}/lib/hsshellscript.pkg
	sed -i "s:\${DEST_IMPORTS}:$(ghc-libdir)/imports:" \
		${S}/lib/hsshellscript.pkg
	ghc-setup-pkg ${S}/lib/hsshellscript.pkg
	make install \
		DESTDIR="${D}" \
		DEST_LIB="$(ghc-libdir)" \
		DEST_IMPORTS="$(ghc-libdir)/imports" \
		DEST_DOC="/usr/share/doc/${PF}" \
		|| die "make failed"
	ghc-install-pkg
	ghc-makeghcilib ${D}/$(ghc-libdir)/libhsshellscript.a
}
