# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/wxhaskell/wxhaskell-0.7.ebuild,v 1.6 2004/09/28 11:59:11 pvdabeel Exp $

DESCRIPTION="a portable and native GUI library for Haskell"
HOMEPAGE="http://wxhaskell.sourceforge.net/"
SRC_URI="mirror://sourceforge/wxhaskell/${PN}-src-${PV}.zip"
LICENSE="wxWinLL-3"
SLOT="0"

KEYWORDS="x86 ppc"

IUSE="doc"

DEPEND="${DEPEND}
	>=virtual/ghc-6.2
	>=x11-libs/wxGTK-2.4.1
	doc? ( >=dev-haskell/haddock-0.6-r2 )"

# the variable ghc_version is used to store the ghc version we are building against

src_compile() {
	# non-standard configure, so econf is not an option
	mv configure configure.orig
	# adapt to Gentoo path convention
	sed -e 's:/doc/html:/share/doc/html:' \
		configure.orig > configure
	# sed -e 's:test "$wxwinlib\":test "":' configure.orig > configure
	chmod u+x ./configure
	# determine ghc library directory
	# (so that it's possible to install the library for
	# multiple versions of ghc)
	local myopts
	ghc_version=`best_version virtual/ghc | sed "s:.*/::"`
	test -n ${ghc_version} && ghclibdir="/usr/lib/${ghc_version}"
	test -n ${ghclibdir} || ghclibdir="/usr/lib"
	test -n ${ghclibdir} && myopts="${myopts} --libdir=${D}/${ghclibdir}"
	./configure \
		--prefix=${D}/usr \
		--hcpkg=/bin/true \
		--with-opengl \
		${myopts} \
		|| die "./configure failed"
	# emake doesn't work
	make || die "make failed"
	# create documentation
	if use doc; then
		make doc || die "make doc failed"
	fi
}

src_install() {
	local f
	make install || die "make install failed"
	for f in ${D}/usr/lib/${ghc_version}/libwxc-*.so; do
		mv ${f} ${D}/usr/lib
	done
	if use doc; then
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

