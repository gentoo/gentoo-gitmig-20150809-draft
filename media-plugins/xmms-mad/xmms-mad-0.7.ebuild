# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-mad/xmms-mad-0.7.ebuild,v 1.1 2004/12/08 07:23:21 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="A XMMS plugin for MAD"
HOMEPAGE="http://xmms-mad.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmms-mad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="media-sound/xmms
	 media-libs/libid3tag
	 media-libs/libmad"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.5.6-mp3header.patch
	touch configure
}

src_install() {
	exeinto `xmms-config --input-plugin-dir`
	doexe src/.libs/libxmmsmad.so || die
	dodoc AUTHORS ChangeLog NEWS README
}
