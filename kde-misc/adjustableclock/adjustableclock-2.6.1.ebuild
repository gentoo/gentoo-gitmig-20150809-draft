# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/adjustableclock/adjustableclock-2.6.1.ebuild,v 1.3 2011/10/29 00:53:13 abcd Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Plasmoid to show date and time in adjustable format using rich text."
HOMEPAGE="http://kde-look.org/content/show.php/Adjustable+Clock?content=92825"
SRC_URI="http://kde-look.org/CONTENT/content-files/92825-${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libplasmaclock)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep plasma-workspace)
"
