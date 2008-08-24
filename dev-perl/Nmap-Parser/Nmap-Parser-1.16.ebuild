# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Nmap-Parser/Nmap-Parser-1.16.ebuild,v 1.1 2008/08/24 08:17:45 tove Exp $

MODULE_AUTHOR=APERSAUD
inherit perl-module

DESCRIPTION="Nmap::Parser - parse nmap scan data with perl"
HOMEPAGE="http://nmapparser.wordpress.com/ http://code.google.com/p/nmap-parser/ http://search.cpan.org/dist/Nmap-Parser/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl
	virtual/perl-Storable
	>=dev-perl/XML-Twig-3.16"

SRC_TEST="do"
