# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hsshellscript/hsshellscript-2.3.0.ebuild,v 1.1 2005/04/08 01:33:00 araujo Exp $

inherit base eutils ghc-package

DESCRIPTION="A Haskell library for UNIX shell scripting tasks"
HOMEPAGE="http://www.volker-wysk.de/hsshellscript/"
SRC_URI="http://www.volker-wysk.de/hsshellscript/dist/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/ghc-6.2
	!>=virtual/ghc-6.4"
RDEPEND=""


src_unpack() {
	base_src_unpack
	cd ${S}
	sed -i -e "/ghc-pkg/d" Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	ghc-setup-pkg ${S}/lib/hsshellscript.pkg
	# Fix hsshellscript.pkg library path
	ghc-fixlibpath "\${DEST_LIB}" "\${DEST_IMPORTS}"
	make install \
		DESTDIR="${D}" \
		DEST_LIB="$(ghc-libdir)" \
		DEST_IMPORTS="$(ghc-libdir)/imports" \
		DEST_DOC="/usr/share/doc/${PF}" \
		|| die "make failed"
	ghc-install-pkg
	ghc-makeghcilib ${D}/$(ghc-libdir)/libhsshellscript.a
}
