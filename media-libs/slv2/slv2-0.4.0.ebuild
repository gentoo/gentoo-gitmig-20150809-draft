# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/slv2/slv2-0.4.0.ebuild,v 1.1 2008/01/02 10:52:24 aballier Exp $

DESCRIPTION="A library to make the use of LV2 plugins as simple as possible for applications"
HOMEPAGE="http://wiki.drobilla.net/SLV2"
SRC_URI="http://download.drobilla.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc jack"

RDEPEND="dev-libs/redland
	media-libs/raptor
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable debug) \
		$(use_enable jack) \
		$(use_enable doc documentation)

	emake || die "make failed"
	if use doc; then
		emake docs || die "creating documentation failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README
	doman doc/man/man3/*
	use doc && dohtml doc/html/*
}
