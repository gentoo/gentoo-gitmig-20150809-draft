# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-server/net-server-0.90.ebuild,v 1.5 2006/07/05 18:46:00 ian Exp $

inherit perl-module

MY_P=Net-Server-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extensible, general Perl server engine"
HOMEPAGE="http://search.cpan.org/~rhandom/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/R/RH/RHANDOM/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""

SRC_TEST="do"

mydoc="README"

DEPEND="dev-perl/IO-Multiplex"
RDEPEND="${DEPEND}"