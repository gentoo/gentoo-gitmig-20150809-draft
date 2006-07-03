# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-FastTemplate/CGI-FastTemplate-1.09.ebuild,v 1.16 2006/07/03 20:29:49 ian Exp $

inherit perl-module

DESCRIPTION="The Perl CGI::FastTemplate Module"
SRC_URI="mirror://cpan/authors/id/J/JM/JMOORE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jmoore/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND=">=perl-core/CGI-2.78-r3"
RDEPEND="${DEPEND}"
