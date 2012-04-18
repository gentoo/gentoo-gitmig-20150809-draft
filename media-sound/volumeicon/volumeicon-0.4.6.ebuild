# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/volumeicon/volumeicon-0.4.6.ebuild,v 1.2 2012/04/18 08:10:34 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION="A lightweight volume control that sits in your systray"
HOMEPAGE="http://softwarebakery.com/maato/volumeicon.html"
SRC_URI="http://softwarebakery.com/maato/files/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa libnotify"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.16:2
	x11-libs/libX11
	alsa? ( media-libs/alsa-lib )
	libnotify? ( >=x11-libs/libnotify-0.7 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS ChangeLog )

src_prepare() {
	epatch "${FILESDIR}"/${P}-glib-2.31.patch
}

src_configure() {
	econf \
		$(use_enable !alsa oss) \
		$(use_enable libnotify notify)
}
