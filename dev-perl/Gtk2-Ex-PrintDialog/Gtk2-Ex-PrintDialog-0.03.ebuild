# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Ex-PrintDialog/Gtk2-Ex-PrintDialog-0.03.ebuild,v 1.3 2007/07/11 14:53:26 armin76 Exp $

inherit perl-module

DESCRIPTION="a simple, pure Perl dialog for printing PostScript data in GTK+ applications"
HOMEPAGE="http://search.cpan.org/~gbrown/"
SRC_URI="mirror://cpan/authors/id/G/GB/GBROWN/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ia64 x86"
IUSE="cups"
#SRC_TEST="do"

DEPEND="cups? ( dev-perl/Net-CUPS )
		dev-perl/gtk2-perl
		>=dev-perl/Locale-gettext-1.04
		dev-lang/perl"
