# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-Session/CGI-Session-4.03.ebuild,v 1.2 2006/01/13 18:14:40 mcummings Exp $

inherit perl-module

DESCRIPTION="persistent session data in CGI applications "
HOMEPAGE="http://search.cpan.org/~HOME/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SH/SHERZODR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="perl-core/Digest-MD5"
