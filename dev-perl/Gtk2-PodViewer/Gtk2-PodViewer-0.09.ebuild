# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-PodViewer/Gtk2-PodViewer-0.09.ebuild,v 1.3 2006/07/04 09:48:30 ian Exp $

inherit perl-module

DESCRIPTION="a Gtk2 widget for displaying Plain old Documentation (POD)."
HOMEPAGE="http://search.cpan.org/~gbrown/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GB/GBROWN/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""

#SRC_TEST="do"

DEPEND=">=x11-libs/gtk+-2
	dev-perl/gtk2-perl
	dev-perl/IO-stringy
	dev-perl/Locale-gettext"
RDEPEND="${DEPEND}"
