# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/convert-ascii-armour/convert-ascii-armour-1.4.ebuild,v 1.11 2005/04/22 12:45:13 blubb Exp $

inherit perl-module

MY_P=Convert-ASCII-Armour-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Convert binary octets into ASCII armoured messages."
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.readme"
SRC_URI="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha hppa amd64 ~mips ~ppc64"
IUSE=""

DEPEND="dev-perl/Compress-Zlib
	dev-perl/Digest-MD5
	dev-perl/MIME-Base64"
