# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kimdaba/kimdaba-2.1.ebuild,v 1.4 2005/07/22 21:25:00 dholm Exp $

inherit kde

#S="${WORKDIR}/${PN}-2005-03-28-noi18n"
DESCRIPTION="KDE Image Database (KimDaBa) is a tool for indexing, searching, and viewing images."
HOMEPAGE="http://ktown.kde.org/kimdaba/"
SRC_URI="http://ktown.kde.org/kimdaba/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="media-libs/libkipi
	|| ( kde-base/kdegraphics-kfile-plugins kde-base/kdegraphics )"

need-kde 3.2

src_unpack()
{
	unpack ${A}
	find ${S}/translations -name Makefile.in | xargs \
		sed -i -e 's|LANG)/doc|LANG)/kimdaba|g'
}
