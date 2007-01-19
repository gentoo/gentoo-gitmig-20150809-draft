# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP/SOAP-0.28-r2.ebuild,v 1.15 2007/01/19 15:46:28 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl Module for SOAP"
SRC_URI="mirror://cpan/authors/id/K/KB/KBROWN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kbrown/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	>=dev-perl/XML-Parser-2.29
	>=www-apache/mod_perl-1.24
	dev-lang/perl"
