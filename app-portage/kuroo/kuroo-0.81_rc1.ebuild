# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/kuroo/kuroo-0.81_rc1.ebuild,v 1.1 2007/08/31 18:34:49 philantrop Exp $

inherit kde eutils

DESCRIPTION="Kuroo is a KDE Portage frontend."
HOMEPAGE="http://kuroo.org/"
SRC_URI="http://files.kuroo.org/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=app-portage/gentoolkit-0.2.3-r1
		>=kde-misc/kdiff3-0.9.92
		>=dev-db/sqlite-2.8.16-r4
	|| ( kde-base/kdesu kde-base/kdebase )"

need-kde 3.5
