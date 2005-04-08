# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/madplay/madplay-0.15.2b.ebuild,v 1.14 2005/04/08 17:28:19 hansmi Exp $

inherit eutils

DESCRIPTION="The MAD audio player"
HOMEPAGE="http://mad.sourceforge.net/"
SRC_URI="mirror://sourceforge/mad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="debug nls esd"

#	~media-libs/libmad-${PV}
#	~media-libs/libid3tag-${PV}
# This version uses the previous libs... the only change is in handling lame encoded mp3s...
# See http://sourceforge.net/project/shownotes.php?group_id=12349&release_id=219475

RDEPEND="esd? ( media-sound/esound )
	~media-libs/libmad-0.15.1b
	~media-libs/libid3tag-0.15.1b"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.11.2 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epunt_cxx #74499
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable debug debugging) \
		$(use_with esd) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc CHANGES CREDITS README TODO VERSION
}
