# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/koppermine/koppermine-1.1.ebuild,v 1.4 2008/02/19 00:19:58 ingmar Exp $

inherit kde

DESCRIPTION="Koppermine is a KDE client for Coppermine Photo Gallery"
HOMEPAGE="http://koppermine.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="
	|| ( =kde-base/kdebase-3.5*
		( =kde-base/kcontrol-3.5* =kde-base/kdialog-3.5* ) )"

need-kde 3
