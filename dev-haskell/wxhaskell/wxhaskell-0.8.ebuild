# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/wxhaskell/wxhaskell-0.8.ebuild,v 1.4 2004/10/26 13:57:18 kosmikus Exp $

inherit wxwidgets

DESCRIPTION="a portable and native GUI library for Haskell"
HOMEPAGE="http://wxhaskell.sourceforge.net/"
SRC_URI="mirror://sourceforge/wxhaskell/${PN}-src-${PV}.zip"
LICENSE="wxWinLL-3"
SLOT="0"

KEYWORDS="x86 ~ppc"

IUSE="doc gtk2"

DEPEND="${DEPEND}
	>=virtual/ghc-6.2
	>=x11-libs/wxGTK-2.4.2-r2
	doc? ( >=dev-haskell/haddock-0.6-r2 )"

# the variable ghc_version is used to store the ghc version we are building against

pkg_setup() {
	ghc_version=`best_version virtual/ghc | sed -e "s:.*/::" -e "s:-r.*::"`
	test -n ${ghc_version} && ghclibdir="/usr/lib/${ghc_version}"
	test -n ${ghclibdir} || ghclibdir="/usr/lib"
	einfo "Using GHC library dir ${ghclibdir}."
}


src_compile() {
	einfo "Using GHC library dir ${ghclibdir}."
	#wxhaskell supports gtk or gtk2, but not unicode yet:
	if ! use gtk2; then
		need-wxwidgets gtk
	else
		need-wxwidgets gtk2
	fi
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
	local wxconfig
	test -n ${ghclibdir} && myopts="${myopts} --libdir=${D}/${ghclibdir}"
	wxconfig="${WX_CONFIG}"
	# --wx-config must appear first according to configure file comments 
	./configure \
		--wx-config=${wxconfig} \
		--prefix=${D}/usr \
		--hcpkg=/bin/true \
		--with-opengl \
		${myopts} \
		|| die "./configure failed"
	emake -j1 || die "make failed"
	# create documentation
	if use doc; then
		emake -j1 doc || die "make doc failed"
	fi
}

src_install() {
	local f
	emake -j1 install || die "make install failed"
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
	wxhlibdir=${ghclibdir} ghc-pkg -u -i ${ghclibdir}/wxcore.pkg
	einfo "Registering wx package"
	wxhlibdir=${ghclibdir} ghc-pkg -u -i ${ghclibdir}/config/wx.pkg
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

