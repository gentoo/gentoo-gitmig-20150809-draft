# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-dh/crypt-dh-0.03.ebuild,v 1.9 2005/04/29 17:00:37 mcummings Exp $

inherit perl-module

MY_P=Crypt-DH-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Diffie-Hellman key exchange system"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa amd64 ~mips"
IUSE=""

DEPEND="dev-perl/math-pari
	dev-perl/crypt-random"
