# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-Session/CGI-Session-3.95.ebuild,v 1.2 2005/05/24 15:34:01 mcummings Exp $

inherit perl-module

DESCRIPTION="persistent session data in CGI applications "
HOMEPAGE="http://search.cpan.org/~HOME/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SH/SHERZODR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND="perl-core/Digest-MD5"
