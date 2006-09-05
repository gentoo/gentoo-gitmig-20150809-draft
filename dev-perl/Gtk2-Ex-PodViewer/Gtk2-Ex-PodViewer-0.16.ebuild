# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Ex-PodViewer/Gtk2-Ex-PodViewer-0.16.ebuild,v 1.4 2006/09/05 20:46:17 gustavoz Exp $

inherit perl-module

DESCRIPTION="a Gtk2 widget for displaying Plain old Documentation (POD)."
HOMEPAGE="http://search.cpan.org/~gbrown/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GB/GBROWN/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ia64 sparc ~x86"
IUSE=""

#SRC_TEST="do"

DEPEND=">=x11-libs/gtk+-2
	dev-perl/gtk2-perl
	dev-perl/IO-stringy
	virtual/perl-PodParser
	dev-perl/Pod-Simple
	dev-perl/Gtk2-Ex-Simple-List
	dev-perl/Locale-gettext
	dev-lang/perl"
RDEPEND="${DEPEND}"

