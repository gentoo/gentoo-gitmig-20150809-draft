# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/raul/raul-0.5.0.ebuild,v 1.1 2008/07/09 07:44:21 aballier Exp $

DESCRIPTION="C++ utility library primarily aimed at audio/musical applications."
HOMEPAGE="http://wiki.drobilla.net/Raul"
SRC_URI="http://download.drobilla.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc jack lash"

RDEPEND=">=dev-cpp/glibmm-2.4
	>=dev-libs/glib-2.0
	dev-libs/boost
	jack? ( >=media-sound/jack-audio-connection-kit-0.107 )
	lash? ( >=media-sound/lash-0.5.2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

src_compile() {
	econf $(use_enable debug) \
		$(use_enable debug pointer-debug) \
		$(use_enable jack enable-jack) \
		$(use_enable jack) \
		$(use_enable lash) \
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
