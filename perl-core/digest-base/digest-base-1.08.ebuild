# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/digest-base/digest-base-1.08.ebuild,v 1.3 2006/07/05 20:04:01 ian Exp $

inherit perl-module

MY_P=Digest-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Modules that calculate message digests"
HOMEPAGE="http://search.cpan.org/~gaas/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~s390 ~ppc64"
SRC_TEST="do"
IUSE=""

mydoc="rfc*.txt"

DEPEND="perl-core/MIME-Base64"
RDEPEND="${DEPEND}"
