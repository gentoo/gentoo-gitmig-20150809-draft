# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/wxhaskell/wxhaskell-0.6.ebuild,v 1.1 2004/03/03 17:12:17 kosmikus Exp $

DESCRIPTION="a portable and native GUI library for Haskell"
HOMEPAGE="http://wxhaskell.sourceforge.net/"
SRC_URI="mirror://sourceforge/wxhaskell/${PN}-src-${PV}.zip"
LICENSE="wxWinLL-3"
SLOT="0"

KEYWORDS="~x86"

IUSE="doc"

DEPEND="${DEPEND}
	>=virtual/ghc-6.2
	>=x11-libs/wxGTK-2.4.1
	doc? ( >=dev-haskell/haddock-0.6-r2 )"

S=${WORKDIR}/${P}

src_compile() {
	# non-standard configure, so econf is not an option
	mv configure configure.orig
	# adapt to Gentoo path convention
	sed -e 's:/doc/html:/share/doc/html:' \
		-e 's:wxwinlibs="`$.*$:wxwinlibs="`$wxconfig --libs` `$wxconfig --gl-libs`":' \
		configure.orig > configure
	# sed -e 's:test "$wxwinlib\":test "":' configure.orig > configure
	chmod u+x ./configure
	# determine ghc library directory
	# (so that it's possible to install the library for
	# multiple versions of ghc)
	local ghc_version
	local myopts
	ghc_version=`best_version virtual/ghc | sed "s:.*/::"`
	test -n ${ghc_version} && ghclibdir="/usr/lib/${ghc_version}"
	test -n ${ghclibdir} || ghclibdir="/usr/lib"
	test -n ${ghclibdir} && myopts="${myopts} --libdir=${D}/${ghclibdir}"
	./configure \
		--prefix=${D}/usr \
		--hcpkg=/bin/true \
		${myopts} \
		|| die "./configure failed"
	# emake doesn't work
	make || die "make failed"
	# create documentation
	if [ `use doc` ]; then
		make doc || die "make doc failed"
	fi
}

src_install() {
	make install || die "make install failed"
	if [ `use doc` ]; then
		dohtml -A haddock -r out/doc/*
		cp -r samples ${D}/usr/share/doc/${PF}
	fi
}

pkg_postinst() {
	einfo "Registering wxcore package"
	wxhlibdir=${ghclibdir} ghc-pkg -u -i ${S}/config/wxcore.pkg
	einfo "Registering wx package"
	wxhlibdir=${ghclibdir} ghc-pkg -u -i ${S}/config/wx.pkg
}

pkg_postrm() {
	# check if another version is still there
	has_version "<${CATEGORY}/${PF}" \
		|| has_version ">${CATEGORY}/${PF}" \
		|| unregister_ghc_packages
}

unregister_ghc_packages() {
	einfo "Unregistering wx package"
	/usr/bin/ghc-pkg -r wx
	einfo "Unregistering wxcore package"
	/usr/bin/ghc-pkg -r wxcore
}

