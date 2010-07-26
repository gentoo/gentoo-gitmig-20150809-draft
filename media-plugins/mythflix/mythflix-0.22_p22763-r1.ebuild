# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythflix/mythflix-0.22_p22763-r1.ebuild,v 1.2 2010/07/26 13:45:08 fauli Exp $

EAPI=2
inherit qt4 mythtv-plugins

DESCRIPTION="NetFlix manager via MythTV."
IUSE=""
KEYWORDS="~amd64 ~ppc x86"

src_install() {
	mythtv-plugins_src_install

	# correct permissions so MythFlix is actually usable
	fperms 755 /usr/share/mythtv/mythflix/scripts/netflix.pl
}
