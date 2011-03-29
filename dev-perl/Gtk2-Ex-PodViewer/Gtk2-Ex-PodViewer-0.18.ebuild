# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-Ex-PodViewer/Gtk2-Ex-PodViewer-0.18.ebuild,v 1.3 2011/03/29 10:17:14 angelos Exp $

MODULE_AUTHOR=GBROWN
EAPI=1
inherit perl-module

DESCRIPTION="a Gtk2 widget for displaying Plain old Documentation (POD)."

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

#SRC_TEST="do"

DEPEND="x11-libs/gtk+:2
	dev-perl/gtk2-perl
	dev-perl/IO-stringy
	virtual/perl-PodParser
	virtual/perl-Pod-Simple
	dev-perl/Gtk2-Ex-Simple-List
	dev-perl/Locale-gettext
	dev-lang/perl"
