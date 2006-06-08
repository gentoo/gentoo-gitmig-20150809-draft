# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/booh/booh-0.8.5.ebuild,v 1.2 2006/06/08 20:38:14 malc Exp $

DESCRIPTION="Static HTML photo album generator"
HOMEPAGE="http://www.zarb.org/~gc/html/booh.html"
SRC_URI="http://www.zarb.org/~gc/resource/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk transcode encode"

DEPEND=">=dev-ruby/ruby-gtk2-0.12.0
	>=dev-lang/ruby-1.8.2
	>=dev-ruby/ruby-gettext-0.8.0
	gtk? ( >=dev-ruby/ruby-gtk2-0.12.0
	>=x11-libs/gtk+-2.6.0 )
	>=media-gfx/imagemagick-6.2.0.4
	transcode? ( media-video/transcode )
	encode? ( media-video/mplayer )"

src_compile() {
	if ! use gtk; then
	  rm bin/booh-gui
	fi
	ruby setup.rb config
	ruby setup.rb setup
	cd ext
	ruby extconf.rb
	make
}

src_install() {
	ruby setup.rb install --prefix="${D}"
	cd ext
	make install DESTDIR=${D} libdir=${D}/`ruby -rrbconfig -e "puts Config::CONFIG['sitelibdir']"` archdir=${D}/`ruby -rrbconfig -e "puts Config::CONFIG['sitearchdir']"`
	cd ..
	dodoc AUTHORS INTERNALS README VERSION THEMES
}
