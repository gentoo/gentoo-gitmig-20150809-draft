# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DOM/XML-DOM-1.43.ebuild,v 1.11 2005/08/26 02:31:28 agriffis Exp $

inherit perl-module

DESCRIPTION="A Perl module for an DOM Level 1 compliant interface"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJMATHER/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~tjmather/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/libwww-perl
	dev-perl/libxml-perl
	dev-perl/XML-Parser
	dev-perl/XML-RegExp"
