# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-random/crypt-random-1.23.ebuild,v 1.7 2006/07/05 14:23:16 ian Exp $

inherit perl-module

MY_P=Crypt-Random-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Cryptographically Secure, True Random Number Generator"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/math-pari
	dev-perl/class-loader"
RDEPEND="${DEPEND}"