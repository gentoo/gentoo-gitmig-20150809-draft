# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-FastTemplate/CGI-FastTemplate-1.09.ebuild,v 1.17 2006/08/04 22:42:44 mcummings Exp $

inherit perl-module

DESCRIPTION="The Perl CGI::FastTemplate Module"
SRC_URI="mirror://cpan/authors/id/J/JM/JMOORE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jmoore/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND=">=perl-core/CGI-2.78-r3
	dev-lang/perl"
RDEPEND="${DEPEND}"
