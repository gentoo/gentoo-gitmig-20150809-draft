# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cgi-Simple/Cgi-Simple-0.077.ebuild,v 1.4 2005/01/22 00:51:47 kloeri Exp $

inherit perl-module


DESCRIPTION="The Perl CGI::Simple Module"
SRC_URI="mirror://cpan/authors/id/J/JF/JFREEMAN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/JFREEMAN/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 ~ppc ~sparc alpha ~ppc64"
IUSE=""

SRC_TEST="do"
