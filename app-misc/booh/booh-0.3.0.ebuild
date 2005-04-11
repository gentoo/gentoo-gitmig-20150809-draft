# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/booh/booh-0.3.0.ebuild,v 1.2 2005/04/11 15:28:29 dams Exp $

inherit eutils

DESCRIPTION="Static HTML photo album generator"
HOMEPAGE="http://www.zarb.org/~gc/html/booh.html"
SRC_URI="http://www.zarb.org/~gc/resource/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gtk transcode encode exif"

DEPEND=">=dev-lang/ruby-1.8.2
	>=dev-ruby/ruby-gettext-0.8.0
	gtk? ( >=dev-ruby/ruby-gtk2-0.12.0 )
	gtk? ( >=x11-libs/gtk+-2.6.0 )
	>=media-gfx/imagemagick-6.2.0.4
	transcode2? ( media-video/transcode )
	encode? ( media-video/mplayer )
	exif? ( media-gfx/exif )"

src_compile() {
	if ! use gtk; then
	  rm bin/booh-gui
	fi
	ruby setup.rb config
	ruby setup.rb setup
}

src_install() {
	ruby setup.rb install --prefix="${D}"
	dodoc AUTHORS COPYING INTERNALS README VERSION
}

