# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/cabal/cabal-0.5.ebuild,v 1.1 2005/02/26 15:26:01 kosmikus Exp $

inherit ghc-package

DESCRIPTION="Haskell Common Architecture for Building Applications and Libraries"
HOMEPAGE="http://haskell.org/cabal"
SRC_URI="http://haskell.org/cabal/release/${P}.tgz"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="${DEPEND}
	>=virtual/ghc-6.2"

S="${WORKDIR}/${PN}"

# The following functions exist because they are likely to be extracted
# to an eclass when other Cabal-based packages are added to Portage.

cabal-configure() {
	./setup configure \
		--ghc --prefix=/usr \
		--with-compiler="$(ghc-getghc)" \
		--with-hc-pkg="$(ghc-getghcpkg)" \
		"$@" || die "setup configure failed"
}

cabal-build() {
	./setup build \
		|| die "setup build failed"
}

cabal-copy() {
	./setup copy \
		--copy-prefix="${D}/usr" \
		|| die "setup copy failed"
}

cabal-pkg() {
	./setup register \
		--gen-script \
		|| die "setup register failed"
	# sed on ghc-pkg when it isn't always called ghc-pkg
	# therefore, sed on a flag (we assume a lot about register.sh here)
	sed -i "s|--auto-ghci-libs\(.*\)$|--force \1 --config-file=\\\\|" register.sh
	echo "${S}/$(ghc-localpkgconf)" >> register.sh
	ghc-setup-pkg
	./register.sh
	ghc-install-pkg
}

src_compile() {
	# bootstrap: build setup
	make HC="$(ghc-getghc)" setup || die "make setup failed"
	# cabal-style configure and compile
	cabal-configure
	cabal-build
}

src_install() {
	cabal-copy
	ghc-makeghcilib ${D}/usr/lib/Cabal-${PV}/libHSCabal-${PV}.a
	cabal-pkg
	# documentation (install directly; generation seems broken to me atm)
	dohtml -r doc/users-guide
	if use doc; then
		dohtml -r doc/API
		dohtml -r doc/pkg-spec-html
		dodoc doc/pkg-spec.pdf
	fi
	dodoc changelog copyright README releaseNotes TODO
}
