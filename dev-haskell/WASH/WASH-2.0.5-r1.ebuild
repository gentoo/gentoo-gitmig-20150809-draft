# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/WASH/WASH-2.0.5-r1.ebuild,v 1.1 2004/11/18 16:08:31 kosmikus Exp $

inherit ghc-package

# the installation bundle is called WashNGo
MY_P="WashNGo"
MY_PV=${MY_P}-${PV}

DESCRIPTION="WASH is a family of embedded domain-specific languages for programming Web applications"
HOMEPAGE="http://www.informatik.uni-freiburg.de/~thiemann/haskell/WASH/"
SRC_URI="http://www.informatik.uni-freiburg.de/~thiemann/haskell/WASH/${MY_PV}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc postgres"

DEPEND=">=virtual/ghc-6.2
	postgres? ( dev-haskell/c2hs
		>=dev-db/postgresql-7.4.3 )"

S=${WORKDIR}/${MY_PV}

src_compile() {
	local myopts
	myopts="${myopts} `use_enable postgres dbconnect`"
	myopts="${myopts} `use_enable doc build-docs`"
	./configure \
		--prefix="${D}usr" \
		--host=${CHOST} \
		--libdir=${D}/$(ghc-libdir) \
		${myopts} \
		--enable-register-package="${S}/$(ghc-localpkgconf)" \
			|| die "configure failed"
	make depend || die "make depend failed"
	make all || die "make all failed"
}

src_install() {
	ghc-setup-pkg
	make install || die "make install failed"
	ghc-install-pkg
	dodoc README
	if use doc; then
		cp -r Examples ${D}/usr/share/doc/${PF}
		cd doc
		dohtml -r *
	fi
}
