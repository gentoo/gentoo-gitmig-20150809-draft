# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/madplay/madplay-0.15.2b.ebuild,v 1.9 2004/07/30 02:30:01 tgall Exp $

IUSE="debug nls esd"

DESCRIPTION="The MAD audio player"
HOMEPAGE="http://mad.sourceforge.net"
SRC_URI="mirror://sourceforge/mad/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha sparc hppa ~mips ~ia64 amd64 ~macos ppc64"

#	~media-libs/libmad-${PV}
#	~media-libs/libid3tag-${PV}
# This version uses the previous libs... the only change is in handling lame encoded mp3s...
# See http://sourceforge.net/project/shownotes.php?group_id=12349&release_id=219475

RDEPEND="esd? ( media-sound/esound )
	~media-libs/libmad-0.15.1b
	~media-libs/libid3tag-0.15.1b"

DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.11.2 )"

src_compile() {
	econf \
	      `use_enable nls` \
	      `use_enable debug debugging` \
	      `use_with esd` \
	      || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc CHANGES COPYRIGHT CREDITS README TODO VERSION
}
