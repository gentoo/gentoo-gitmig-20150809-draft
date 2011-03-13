# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/mypaint/mypaint-0.9.0.ebuild,v 1.6 2011/03/13 16:06:33 hwoarang Exp $

EAPI=2

inherit eutils fdo-mime multilib scons-utils toolchain-funcs

DESCRIPTION="fast and easy graphics application for digital painters"
HOMEPAGE="http://mypaint.intilinux.com/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/pygtk
	dev-python/numpy
	>=dev-python/pycairo-1.4
	>=dev-lang/python-2.4
	<dev-lang/python-3
	dev-libs/protobuf[python]"
DEPEND="${RDEPEND}
	>=dev-util/scons-1.0
	dev-lang/swig"

src_prepare() {
	# multilib support
	sed -i -e "s:lib\/${PN}:$(get_libdir)\/${PN}:" "${S}"/SConstruct || die
	# respect CXXFLAGS,CXX,LDFLAGS
	epatch "${FILESDIR}"/${P}-gentoo.patch
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

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
