# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cgi-Simple/Cgi-Simple-0.077.ebuild,v 1.1 2004/12/05 03:16:32 mcummings Exp $

inherit perl-module


DESCRIPTION="The Perl CGI::Simple Module"
SRC_URI="mirror://cpan/authors/id/J/JF/JFREEMAN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/JFREEMAN/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

SRC_TEST="do"
