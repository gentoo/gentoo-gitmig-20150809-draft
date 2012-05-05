# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/mypaint/mypaint-1.0.0-r1.ebuild,v 1.5 2012/05/05 07:00:23 jdhore Exp $

EAPI=4

PYTHON_DEPEND="2:2.5"

inherit eutils fdo-mime gnome2-utils multilib scons-utils toolchain-funcs python

DESCRIPTION="fast and easy graphics application for digital painters"
HOMEPAGE="http://mypaint.intilinux.com/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pygtk
	dev-python/numpy
	>=dev-python/pycairo-1.4
	dev-libs/protobuf[python]"
DEPEND="${RDEPEND}
	dev-lang/swig
	virtual/pkgconfig"

pkg_setup(){
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# multilib support
	sed -i -e "s:lib\/${PN}:$(get_libdir)\/${PN}:" "${S}"/SConstruct || die
	# respect CXXFLAGS,CXX,LDFLAGS
	epatch "${FILESDIR}"/${PN}-0.9.1-gentoo.patch
}

src_compile() {
	#workaround scons bug with locales. Bug #352700
	export LANG="en_US.UTF-8"
	tc-export CXX
	escons || die "scons failed"
}

src_install () {
	escons prefix="${D}/usr" install || die "scons install failed"
	newicon pixmaps/${PN}_logo.png ${PN}.png
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	python_mod_cleanup /usr/share/${PN}
}
