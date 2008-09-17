# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/raul/raul-0.5.1.ebuild,v 1.1 2008/09/17 06:40:25 aballier Exp $

DESCRIPTION="C++ utility library primarily aimed at audio/musical applications."
HOMEPAGE="http://wiki.drobilla.net/Raul"
SRC_URI="http://download.drobilla.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc jack test"

RDEPEND=">=dev-cpp/glibmm-2.4
	>=dev-libs/glib-2.0
	dev-libs/boost
	jack? ( >=media-sound/jack-audio-connection-kit-0.107 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_compile() {
	econf $(use_enable debug) \
		$(use_enable debug pointer-debug) \
		$(use_enable jack) \
		$(use_enable test unit-tests) \
		$(use_enable doc documentation)
	emake || die "make failed"
	if use doc; then
		emake docs || die "failed to create the documentation"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README
	use doc && dohtml -r doc/html/*
}
