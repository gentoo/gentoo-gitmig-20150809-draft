# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rubyripper/rubyripper-0.2.ebuild,v 1.1 2006/09/15 19:21:45 flameeyes Exp $

DESCRIPTION="A secure audio ripper for linux"
HOMEPAGE="http://rubyforge.org/projects/rubyripper/"
SRC_URI="http://rubyforge.org/frs/download.php/12158/${P}.tar.bz2"
IUSE="flac mp3 vorbis"

LICENSE="GPL-2"
KEYWORDS="~amd64"
RDEPEND="dev-ruby/ruby-libglade2
	 dev-ruby/ruby-freedb
	 virtual/cdrtools
	 media-sound/cdparanoia
	 flac? ( media-libs/flac )
	 mp3? ( media-sound/lame )
	 vorbis? ( media-sound/vorbis-tools )"

SLOT="0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's|./rr_lib.rb|/usr/share/rubyripper/rr_lib.rb|' rubyripper_cli.rb rubyripper_gtk2.rb || die "sed failed"
	sed -i -e 's|rubyripper.glade|/usr/share/rubyripper/rubyripper.glade|' rubyripper_gtk2.rb || die "sed failed"
}

src_install() {
	cd "${S}"
	newbin rubyripper_cli.rb rrip-cli
	newbin rubyripper_gtk2.rb rrip-gui
	dodir /usr/share/rubyripper
	insinto /usr/share/rubyripper
	doins rubyripper.glade rr_lib.rb
}

pkg_postinst() {
	echo ""
	einfo "Rubyripper now has cli and gui versions, which are installed"
	einfo "as rrip-cli and rrip-gui respectively."
	echo ""
}
