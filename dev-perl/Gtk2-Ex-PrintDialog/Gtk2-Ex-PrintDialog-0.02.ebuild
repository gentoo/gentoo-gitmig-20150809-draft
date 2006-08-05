# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Ex-PrintDialog/Gtk2-Ex-PrintDialog-0.02.ebuild,v 1.10 2006/08/05 04:16:08 mcummings Exp $

inherit perl-module

DESCRIPTION="a simple, pure Perl dialog for printing PostScript data in GTK+ applications"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
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

RDEPEND="${DEPEND}"
