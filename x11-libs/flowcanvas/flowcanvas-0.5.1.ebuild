# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/flowcanvas/flowcanvas-0.5.1.ebuild,v 1.3 2009/08/02 21:09:04 chainsaw Exp $

DESCRIPTION="Gtkmm/Gnomecanvasmm widget for boxes and lines environments"
HOMEPAGE="http://wiki.drobilla.net/FlowCanvas"
SRC_URI="http://download.drobilla.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug doc"

RDEPEND="dev-libs/boost
	>=dev-cpp/gtkmm-2.4
	>=dev-cpp/libgnomecanvasmm-2.6
	media-gfx/graphviz"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_compile() {
	econf $(use_enable debug) \
		$(use_enable doc documentation)
	emake || die "make failed"
	if use doc; then
		emake docs || die "make docs failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README
	use doc && dohtml -r doc/html/*
}
