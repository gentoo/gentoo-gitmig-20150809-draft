# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DOM/XML-DOM-1.43.ebuild,v 1.8 2005/01/04 14:08:08 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl module for an DOM Level 1 compliant interface"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJMATHER/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~tjmather/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/libwww-perl
	dev-perl/libxml-perl
	dev-perl/XML-Parser
	dev-perl/XML-RegExp"
