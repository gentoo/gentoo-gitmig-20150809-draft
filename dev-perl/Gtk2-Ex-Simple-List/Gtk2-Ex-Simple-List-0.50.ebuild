# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Ex-Simple-List/Gtk2-Ex-Simple-List-0.50.ebuild,v 1.11 2007/07/10 23:33:28 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="A simple interface to Gtk2's complex MVC list widget "
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/R/RM/RMCFARLA/Gtk2-Perl-Ex/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=x11-libs/gtk+-2
	dev-lang/perl"
RDEPEND=">=dev-perl/gtk2-perl-1.060
		>=dev-perl/glib-perl-1.062"
