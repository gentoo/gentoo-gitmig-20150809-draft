# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-PodViewer/Gtk2-PodViewer-0.13.ebuild,v 1.10 2007/01/15 22:37:15 mcummings Exp $

inherit perl-module

DESCRIPTION="a Gtk2 widget for displaying Plain old Documentation (POD)."
HOMEPAGE="http://search.cpan.org/~gbrown/"
SRC_URI="mirror://cpan/authors/id/G/GB/GBROWN/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

#SRC_TEST="do"

DEPEND=">=x11-libs/gtk+-2
	dev-perl/gtk2-perl
	dev-perl/Gtk2-Ex-PodViewer
	dev-lang/perl"
