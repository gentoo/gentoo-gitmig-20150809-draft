# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/teg/teg-0.11.1.ebuild,v 1.5 2004/10/08 15:32:19 pvdabeel Exp $

inherit gnome2

DESCRIPTION="Gnome Risk Clone"
HOMEPAGE="http://teg.sourceforge.net/"
SRC_URI="mirror://sourceforge/teg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE="nls"

DEPEND="virtual/libc
	virtual/x11
	dev-libs/glib
	gnome-base/libgnomeui
	gnome-base/libgnome"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"
