# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XQL/XML-XQL-0.68.ebuild,v 1.10 2005/08/26 02:37:44 agriffis Exp $

inherit perl-module

DESCRIPTION="A Perl module that allows you to perform XQL queries on XML trees"
HOMEPAGE="http://search.cpan.org/~tjmather/${P}"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJMATHER/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE=""

DEPEND=">=dev-perl/libxml-perl-0.07-r1
	>=dev-perl/XML-DOM-1.39-r1
	>=dev-perl/Parse-Yapp-1.05
	dev-perl/libwww-perl
	>=dev-perl/DateManip-5.40-r1"
