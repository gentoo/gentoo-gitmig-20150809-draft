# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/profuse/profuse-0.25.4.ebuild,v 1.8 2009/07/02 23:58:26 jer Exp $

DESCRIPTION="use flags editor, with good features and 3 GUIs (dialog, ncurses and gtk2)."
HOMEPAGE="http://damz.net/profuse/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~hppa ppc ppc64 sparc x86"
IUSE="gtk ncurses"

RDEPEND="dev-lang/perl
>=dev-util/dialog-1.0.20050206
dev-perl/TermReadKey
>=dev-util/libconf-0.39.21
gtk? ( >=dev-perl/gtk2-fu-0.10 )
ncurses? ( dev-perl/Curses-UI )"

src_install() {
	emake install PREFIX="${D}"/usr || die "make install failed"
}
