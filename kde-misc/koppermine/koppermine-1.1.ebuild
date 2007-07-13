# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/koppermine/koppermine-1.1.ebuild,v 1.3 2007/07/13 05:55:28 mr_bones_ Exp $

inherit kde

RDEPEND="|| ( ( kde-base/kcontrol kde-base/kdialog )
			kde-base/kdebase )"

need-kde 3

IUSE=""
DESCRIPTION="Koppermine is a KDE client for Coppermine Photo Gallery"
HOMEPAGE="http://koppermine.sourceforge.net"
SRC_URI="mirror://sourceforge/koppermine/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"
