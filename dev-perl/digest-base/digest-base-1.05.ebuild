# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/digest-base/digest-base-1.05.ebuild,v 1.15 2004/07/21 21:54:42 tgall Exp $

inherit perl-module

MY_P=Digest-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="MD5 message digest algorithm"
HOMEPAGE="http://http://www.cpan.org/modules/by-authors/id/G/GA/GAAS/${MY_P}.readme"
SRC_URI="http://www.cpan.org/modules/by-authors/id/G/GA/GAAS/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 s390 ppc64"
IUSE=""

mydoc="rfc*.txt"
