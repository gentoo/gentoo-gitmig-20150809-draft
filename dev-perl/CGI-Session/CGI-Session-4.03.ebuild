# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-Session/CGI-Session-4.03.ebuild,v 1.7 2006/07/03 20:30:43 ian Exp $

inherit perl-module

DESCRIPTION="persistent session data in CGI applications "
HOMEPAGE="http://search.cpan.org/~HOME/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SH/SHERZODR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-Digest-MD5"
RDEPEND="${DEPEND}"