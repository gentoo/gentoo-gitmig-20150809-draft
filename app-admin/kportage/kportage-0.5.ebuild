# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

inherit kde-base

need-kde 3

DESCRIPTION="A graphical frontend for portage"
SRC_URI="http://freesoftware.fsf.org/download/${PN}/${PN}.pkg/${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.freesoftware.fsf.org/kportage/"

LICENSE="GPL-2"
KEYWORDS="x86"

newdepend "	kde-base/kdebase
	>=sys-apps/portage-2.0.26"
