# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Ex-Simple-List/Gtk2-Ex-Simple-List-0.500.0.ebuild,v 1.2 2011/09/03 21:04:43 tove Exp $

EAPI=4
MODULE_AUTHOR=RMCFARLA
MODULE_VERSION=0.50
MODULE_SECTION=Gtk2-Perl-Ex
inherit perl-module

DESCRIPTION="A simple interface to Gtk2's complex MVC list widget "

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

DEPEND="x11-libs/gtk+:2"
RDEPEND="${DEPEND}
	>=dev-perl/gtk2-perl-1.060
	>=dev-perl/glib-perl-1.062"

# needs X
SRC_TEST="no"
