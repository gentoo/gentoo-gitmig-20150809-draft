# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/eq-audacious/eq-audacious-0.9.ebuild,v 1.2 2008/05/06 12:33:30 joker Exp $

DESCRIPTION="31-band equalizer for Audacious"
HOMEPAGE="http://audacious-media-player.org/~nenolod/audacious/plugins.php"
SRC_URI="http://audacious-media-player.org/~nenolod/audacious/plugins/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug mmx sse sse2"

RDEPEND="media-sound/audacious"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

pkg_config() {
	econf $(use_enable debug)
		$(use_enable mmx)
		$(use_enable sse)
		$(use_enable sse2) || die "econf died"
}

src_install() {
	emake DESTDIR="${D}" libdir=`pkg-config audacious --variable=effect_plugin_dir` install || emake install died

	dodoc AUTHORS BUGS ChangeLog NEWS README README.BSD SKINS TODO
}
