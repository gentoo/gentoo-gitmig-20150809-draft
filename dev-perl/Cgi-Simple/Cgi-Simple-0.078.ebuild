# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cgi-Simple/Cgi-Simple-0.078.ebuild,v 1.2 2007/07/10 23:33:29 mr_bones_ Exp $

inherit perl-module

MY_P="CGI-Simple-${PV}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Simple totally OO CGI interface that is CGI.pm compliant"
SRC_URI="mirror://cpan/authors/id/A/AN/ANDYA/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~andya/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"
RDEPEND="dev-lang/perl
	dev-perl/version"
DEPEND="dev-perl/module-build
	${RDEPEND}"
