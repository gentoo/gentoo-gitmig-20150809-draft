# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-xmmsmplayer/xmms-xmmsmplayer-0.5-r2.ebuild,v 1.1 2006/01/12 01:27:12 metalgod Exp $

inherit eutils

IUSE=""

MY_PN="xmmsmplayer"
MY_P="${MY_PN}-${PV}"

S="${WORKDIR}/${MY_P}"

DESCRIPTION="Xmms-Mplayer is a input plugin for xmms that allows you to play all video files in xmms."
HOMEPAGE="http://xmmsmplayer.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmmsmplayer/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="media-sound/xmms
	media-video/mplayer"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/exts-filter.patch
	epatch ${FILESDIR}/${P}-sigsegvfix.patch
}

src_compile() {
	econf --libdir=`xmms-config --input-plugin-dir`
	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS README
}
