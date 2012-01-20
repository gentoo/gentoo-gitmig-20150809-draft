# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/volumeicon/volumeicon-0.4.6.ebuild,v 1.1 2012/01/20 18:30:17 ssuominen Exp $

EAPI=4

DESCRIPTION="A lightweight volume control that sits in your systray"
HOMEPAGE="http://softwarebakery.com/maato/volumeicon.html"
SRC_URI="http://softwarebakery.com/maato/files/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa libnotify"

RDEPEND=">=x11-libs/gtk+-2.16:2
	x11-libs/libX11
	alsa? ( media-libs/alsa-lib )
	libnotify? ( >=x11-libs/libnotify-0.7 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS ChangeLog )

src_configure() {
	econf \
		$(use_enable !alsa oss) \
		$(use_enable libnotify notify)
}
