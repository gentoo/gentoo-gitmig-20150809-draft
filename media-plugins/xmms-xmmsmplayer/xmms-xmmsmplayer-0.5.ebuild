# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-xmmsmplayer/xmms-xmmsmplayer-0.5.ebuild,v 1.7 2005/03/28 16:59:09 astinus Exp $

IUSE=""

MY_PN="xmmsmplayer"
MY_P="${MY_PN}-${PV}"

S="${WORKDIR}/${MY_P}"

DESCRIPTION="Xmms-Mplayer is a input plugin for xmms that allows you to play all video files in xmms."
HOMEPAGE="http://xmmsmplayer.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmmsmplayer/${MY_P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64 ~sparc"

DEPEND="media-sound/xmms
	media-video/mplayer"

src_install() {
	make DESTDIR="${D}" libdir=`xmms-config --input-plugin-dir` install || die
	dodoc AUTHORS COPYING README
}

pkg_postinst() {
	einfo "*** WARNING: XMMS will play all mplayer supported file"
	einfo "once the mplayer input plugin is configured"
}
