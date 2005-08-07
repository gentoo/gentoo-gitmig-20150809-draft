# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/vdrplugin-rebuild/vdrplugin-rebuild-0.1.ebuild,v 1.2 2005/08/07 14:53:23 zzam Exp $

DESCRIPTION="A utility to rebuild any plugins for vdr which you have installed."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

src_install() {
	newsbin ${FILESDIR}/${P} ${PN}
}

