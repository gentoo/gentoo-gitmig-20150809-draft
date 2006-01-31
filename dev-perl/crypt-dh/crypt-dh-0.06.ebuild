# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-dh/crypt-dh-0.06.ebuild,v 1.4 2006/01/31 22:28:31 agriffis Exp $

inherit perl-module

MY_P=Crypt-DH-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Diffie-Hellman key exchange system"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ~mips ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-perl/math-pari
	>=perl-core/Math-BigInt-1.60
	dev-perl/crypt-random"
