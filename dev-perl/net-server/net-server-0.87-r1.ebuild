# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-server/net-server-0.87-r1.ebuild,v 1.4 2005/06/18 14:45:37 corsair Exp $

inherit perl-module

MY_P=Net-Server-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extensible, general Perl server engine"
HOMEPAGE="http://search.cpan.org/~bbb/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/B/BB/BBB/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

mydoc="README"

DEPEND="dev-perl/IO-Multiplex"
