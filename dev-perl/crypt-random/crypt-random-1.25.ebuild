# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-random/crypt-random-1.25.ebuild,v 1.13 2010/01/09 19:07:25 grobian Exp $

inherit perl-module

MY_P=Crypt-Random-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Cryptographically Secure, True Random Number Generator"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-perl/math-pari-2.010603
	dev-perl/class-loader
	dev-lang/perl"
