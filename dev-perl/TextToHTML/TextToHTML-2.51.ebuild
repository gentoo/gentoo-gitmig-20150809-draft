# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TextToHTML/TextToHTML-2.51.ebuild,v 1.1 2008/08/02 19:17:44 tove Exp $

inherit perl-module

MY_P=txt2html-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="HTML::TextToHTML - convert plain text file to HTML"
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RU/RUBYKAT/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/txt2html/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/YAML-Syck
	virtual/perl-Getopt-Long
	dev-perl/Getopt-ArgvFile"

SRC_TEST="do"
