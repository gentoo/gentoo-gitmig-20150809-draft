# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Ex-PodViewer/Gtk2-Ex-PodViewer-0.14.ebuild,v 1.6 2006/02/20 19:55:24 mcummings Exp $

inherit perl-module eutils

DESCRIPTION="a Gtk2 widget for displaying Plain old Documentation (POD)."
HOMEPAGE="http://search.cpan.org/~gbrown/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GB/GBROWN/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~sparc x86"
IUSE=""

#SRC_TEST="do"

DEPEND=">=x11-libs/gtk+-2
	dev-perl/gtk2-perl
	dev-perl/IO-stringy
	virtual/perl-PodParser
	dev-perl/Pod-Simple
	dev-perl/Gtk2-Ex-Simple-List
	dev-perl/Locale-gettext"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/gtk2-ex-podviewer-makefile.patch
}
