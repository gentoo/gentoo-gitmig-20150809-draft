# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-scrobbler/xmms-scrobbler-0.3.8.1.ebuild,v 1.1 2005/10/23 21:41:09 metalgod Exp $

IUSE="debug"

DESCRIPTION="Audioscrobbler music-profiling plugin for XMMS"
HOMEPAGE="http://www.audioscrobbler.com/"
SRC_URI="http://www.pipian.com/stuffforchat/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="media-sound/xmms
	net-misc/curl
	>=media-libs/musicbrainz-2.0.2-r2"

src_compile() {
	if use debug;
		then DBG='--enable-debug';
		else DBG='';
	fi
	econf '--disable-bmp-plugin' ${DBG} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog INSTALL NEWS README
}
