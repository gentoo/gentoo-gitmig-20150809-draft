# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD5/Digest-MD5-2.33.ebuild,v 1.4 2004/01/07 18:03:53 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="MD5 message digest algorithm"
SRC_URI="http://www.cpan.org/modules/by-authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://http://www.cpan.org/modules/by-authors/id/G/GA/GAAS/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha ~hppa ~arm ia64"

mydoc="rfc*.txt"

DEPEND="dev-perl/digest-base"
