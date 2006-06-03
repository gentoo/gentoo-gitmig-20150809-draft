# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-rack/jack-rack-1.4.4.ebuild,v 1.2 2006/06/03 20:48:55 ticho Exp $

IUSE="gnome ladcca nls xml"

inherit eutils

DESCRIPTION="JACK Rack is an effects rack for the JACK low latency audio API."
HOMEPAGE="http://jack-rack.sourceforge.net/"
SRC_URI="mirror://sourceforge/jack-rack/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="ladcca? ( >=media-libs/ladcca-0.4 )
	media-libs/liblrdf
	>=x11-libs/gtk+-2.0.6-r2
	>=media-libs/ladspa-sdk-1.12
	media-sound/jack-audio-connection-kit
	gnome? ( >=gnome-base/libgnomeui-2 )
	nls? ( sys-devel/gettext )
	xml? ( dev-libs/libxml2 )"

MAKEOPTS="-j1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gtkdep.patch
}

src_compile() {
	econf \
		`use_enable gnome` \
		`use_enable xml` \
		`use_enable ladcca` \
		`use_enable nls` \
		|| die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO
}
