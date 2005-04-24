# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-FastTemplate/CGI-FastTemplate-1.09.ebuild,v 1.11 2005/04/24 15:02:43 mcummings Exp $

inherit perl-module

CATEGORY="dev-perl"
DESCRIPTION="The Perl CGI::FastTemplate Module"
SRC_URI="mirror://cpan/authors/id/J/JM/JMOORE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jmoore/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc alpha sparc"
IUSE=""

DEPEND="${DEPEND}
		>=dev-perl/CGI-2.78-r3"
