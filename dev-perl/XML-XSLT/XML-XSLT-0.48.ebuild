# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XSLT/XML-XSLT-0.48.ebuild,v 1.14 2006/07/05 14:00:09 ian Exp $

inherit perl-module

DESCRIPTION="A Perl module to parse XSL Transformational sheets"
SRC_URI="mirror://cpan/authors/id/J/JS/JSTOWE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jstowe/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/XML-Parser-2.29
	>=dev-perl/XML-DOM-1.25
	>=dev-perl/libwww-perl-5.48"
RDEPEND="${DEPEND}"