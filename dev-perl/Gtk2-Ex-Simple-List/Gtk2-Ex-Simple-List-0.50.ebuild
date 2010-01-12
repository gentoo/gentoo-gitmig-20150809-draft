# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Ex-Simple-List/Gtk2-Ex-Simple-List-0.50.ebuild,v 1.13 2010/01/12 07:26:42 tove Exp $

MODULE_AUTHOR=RMCFARLA
MODULE_SECTION=Gtk2-Perl-Ex
inherit perl-module

DESCRIPTION="A simple interface to Gtk2's complex MVC list widget "

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	dev-lang/perl"
RDEPEND="${DEPEND}
	>=dev-perl/gtk2-perl-1.060
	>=dev-perl/glib-perl-1.062"

# needs X
SRC_TEST="no"
