# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/profuse/profuse-0.25.3.ebuild,v 1.2 2006/02/15 08:50:38 corsair Exp $

DESCRIPTION="use flags editor, with good features and 3 GUIs (dialog, ncurses and gtk2)."
HOMEPAGE="http://libconf.net/profuse/"
SRC_URI="http://libconf.net/profuse/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ppc64 ~sparc ~x86"
IUSE="gtk ncurses"

RDEPEND="dev-lang/perl
>=dev-util/dialog-1.0.20050206
dev-perl/TermReadKey
>=dev-util/libconf-0.39.21
gtk? ( >=dev-perl/gtk2-fu-0.10 )
ncurses? ( dev-perl/Curses-UI )"

src_install() {
	make install PREFIX="${D}"/usr || die "make install failed"
}
