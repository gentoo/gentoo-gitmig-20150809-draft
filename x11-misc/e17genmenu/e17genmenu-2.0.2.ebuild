# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/e17genmenu/e17genmenu-2.0.2.ebuild,v 1.1 2005/07/29 23:40:32 vapier Exp $

EKEY_STATE=live
inherit enlightenment

DESCRIPTION="app to automatically generate menu entries for e17"
HOMEPAGE="http://sourceforge.net/projects/e17genmenu"
SRC_URI="mirror://sourceforge/e17genmenu/${P}.tar.gz"

DEPEND="dev-libs/engrave
	dev-libs/eet
	x11-libs/evas
	x11-wm/e"
