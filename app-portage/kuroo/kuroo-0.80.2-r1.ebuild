# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kuroo/kuroo-0.80.2-r1.ebuild,v 1.1 2006/08/16 19:27:00 carlo Exp $

inherit kde

DESCRIPTION="Kuroo is a KDE Portage frontend."
HOMEPAGE="http://kuroo.org/"
SRC_URI="http://files.kuroo.org/files/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

RDEPEND="app-portage/gentoolkit
	kde-misc/kdiff3
	|| ( kde-base/kdesu kde-base/kdebase )"
need-kde 3.2
