# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/convert-ascii-armour/convert-ascii-armour-1.4.ebuild,v 1.3 2003/10/28 01:23:40 brad_mssw Exp $

inherit perl-module

MY_P=Convert-ASCII-Armour-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Convert binary octets into ASCII armoured messages."
SRC_URI="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~ppc ~sparc ~amd64"

DEPEND="dev-perl/Compress-Zlib
		dev-perl/Digest-MD5
		dev-perl/MIME-Base64"
