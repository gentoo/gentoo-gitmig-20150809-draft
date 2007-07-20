# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rubyripper/rubyripper-0.4.2-r1.ebuild,v 1.1 2007/07/20 08:35:34 drac Exp $

inherit ruby

DESCRIPTION="a secure audio ripper for linux"
HOMEPAGE="http://code.google.com/p/rubyripper"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="flac mp3 vorbis"

RDEPEND="dev-ruby/ruby-gtk2
	virtual/eject
	media-sound/cd-discid
	media-sound/cdparanoia
	flac? ( media-libs/flac )
	mp3? ( media-sound/lame )
	vorbis? ( media-sound/vorbis-tools )"

src_install() {
	newbin rubyripper_cli.rb rrip_cli
	newbin rubyripper_gtk2.rb rrip_gui
	doicon rubyripper_22.png
	domenu rubyripper.desktop
	doruby rr_lib.rb
	dodoc README
}

pkg_postinst() {
	echo ""
	elog "Rubyripper now has cli and gui versions, which are installed"
	elog "as rrip_cli and rrip_gui respectively."
	echo ""
}
