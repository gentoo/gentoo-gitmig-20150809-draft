# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kentoo/kentoo-0.3.ebuild,v 1.1 2004/07/28 20:32:58 centic Exp $

inherit kde-base || die
need-kde 3.2

DESCRIPTION="KDE Portage frontend"
HOMEPAGE="http://www.ralfhoelzer.com/kentoo.html"
SRC_URI="http://www.ece.cmu.edu/~rholzer/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

