# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kuroo/kuroo-0.71.0_rc2.ebuild,v 1.1 2005/11/13 12:33:25 cryos Exp $

inherit kde

DESCRIPTION="A KDE Portage frontend"
HOMEPAGE="http://guitoo.sourceforge.net"
SRC_URI="mirror://sourceforge/guitoo/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

RDEPEND="app-portage/gentoolkit
	!app-portage/guitoo
	kde-misc/kdiff3"

need-kde 3.2
