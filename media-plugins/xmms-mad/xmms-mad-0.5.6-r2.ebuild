# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-mad/xmms-mad-0.5.6-r2.ebuild,v 1.3 2004/11/08 00:57:33 eradicator Exp $

IUSE=""

NOBMP="1"
inherit xmms-plugin

DESCRIPTION="A XMMS plugin for MAD"
HOMEPAGE="http://xmms-mad.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmms-mad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="media-libs/libmad"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PATCHES="${FILESDIR}/${P}-mp3header.patch
	 ${FILESDIR}/${P}-cflags.patch"

XMMS_PLUGIN_INSTALL="doexe"
xmms_plugin_type="input"
myins_xmms="src/.libs/libxmmsmad.so"
myins_bmp=${myins_xmms}

DOCS="AUTHORS ChangeLog NEWS README"
