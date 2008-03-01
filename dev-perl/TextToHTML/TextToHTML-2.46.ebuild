# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TextToHTML/TextToHTML-2.46.ebuild,v 1.2 2008/03/01 23:08:55 hd_brummy Exp $

inherit perl-module

DESCRIPTION="HTML::TextToHTML - convert plain text file to HTML"
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RU/RUBYKAT/txt2html-${PV}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rubykat/txt2html-2.46"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

SRC_TEST="do"

DEPEND="dev-lang/perl
		virtual/perl-Getopt-Long
		dev-perl/Getopt-ArgvFile"

S="${WORKDIR}/txt2html-${PV}"
