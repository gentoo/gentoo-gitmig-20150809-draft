# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpdscribble/mpdscribble-0.22.ebuild,v 1.2 2011/07/16 19:08:36 hwoarang Exp $

EAPI=4
inherit eutils

DESCRIPTION="An MPD client that submits information to Audioscrobbler"
HOMEPAGE="http://mpd.wikia.com/wiki/Client:Mpdscribble"
SRC_URI="mirror://sourceforge/musicpd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ~x86"
IUSE="+curl"

RDEPEND=">=dev-libs/glib-2.16:2
	>=media-libs/libmpdclient-2.2
	curl? ( net-misc/curl )
	!curl? ( net-libs/libsoup:2.4 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	local myclient=soup
	use curl && myclient=curl
	econf \
		--with-http-client=${myclient} \
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	default
	newinitd "${FILESDIR}/mpdscribble.rc" mpdscribble
	dodir /var/cache/mpdscribble
}
