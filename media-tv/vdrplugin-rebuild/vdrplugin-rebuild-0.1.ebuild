# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/vdrplugin-rebuild/vdrplugin-rebuild-0.1.ebuild,v 1.3 2005/08/08 10:57:26 dholm Exp $

DESCRIPTION="A utility to rebuild any plugins for vdr which you have installed."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

src_install() {
	newsbin ${FILESDIR}/${P} ${PN}
}

