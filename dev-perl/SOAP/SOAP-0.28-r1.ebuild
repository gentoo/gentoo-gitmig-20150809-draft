# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP/SOAP-0.28-r1.ebuild,v 1.17 2005/05/09 10:28:57 beu Exp $

inherit perl-module

DESCRIPTION="A Perl Module for SOAP"
SRC_URI="mirror://cpan/authors/id/K/KB/KBROWN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kbrown/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.29
	>=www-apache/mod_perl-1.24"
