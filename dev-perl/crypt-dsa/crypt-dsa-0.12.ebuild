# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/crypt-dsa/crypt-dsa-0.12.ebuild,v 1.7 2005/03/23 00:39:20 mcummings Exp $

inherit perl-module

MY_P=Crypt-DSA-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="DSA Signatures and Key Generation"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.readme"
SRC_URI="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa ~mips"
IUSE=""

DEPEND="dev-perl/data-buffer
	dev-perl/math-pari
	dev-perl/crypt-random
	dev-perl/Digest-SHA1
	dev-perl/convert-pem"
