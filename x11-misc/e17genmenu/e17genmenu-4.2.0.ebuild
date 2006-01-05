# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/e17genmenu/e17genmenu-4.2.0.ebuild,v 1.1 2006/01/05 04:55:01 vapier Exp $

EKEY_STATE=live
inherit enlightenment

DESCRIPTION="app to automatically generate menu entries for e17"
HOMEPAGE="http://sourceforge.net/projects/e17genmenu"
SRC_URI="mirror://sourceforge/e17genmenu/${P}.tar.gz"

DEPEND="dev-libs/engrave
	dev-libs/eet
	x11-libs/evas
	x11-wm/e"

S=${WORKDIR}/${PN}
