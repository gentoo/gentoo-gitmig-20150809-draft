# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rubyripper/rubyripper-0.4.1.ebuild,v 1.1 2007/05/12 17:17:36 beandog Exp $

inherit ruby

DESCRIPTION="A secure audio ripper for linux"
HOMEPAGE="http://code.google.com/p/rubyripper/"
SRC_URI="http://rubyripper.googlecode.com/files/${P}.tar.bz2"
IUSE="flac mp3 vorbis"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
RDEPEND="dev-ruby/ruby-libglade2
	virtual/eject
	media-sound/cd-discid
	media-sound/cdparanoia
	flac? ( media-libs/flac )
	mp3? ( media-sound/lame )
	vorbis? ( media-sound/vorbis-tools )"

SLOT="0"

src_install() {
	newbin rubyripper_cli.rb rrip-cli
	newbin rubyripper_gtk2.rb rrip-gui
	dodir /usr/share/rubyripper
	insinto /usr/share/rubyripper
	doins rubyripper.glade
	doins rubyripper_22.png
	doruby rr_lib.rb
}

pkg_postinst() {
	echo ""
	elog "Rubyripper now has cli and gui versions, which are installed"
	elog "as rrip-cli and rrip-gui respectively."
	echo ""
}
