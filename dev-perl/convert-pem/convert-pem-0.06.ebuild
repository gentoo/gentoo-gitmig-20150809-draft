# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/convert-pem/convert-pem-0.06.ebuild,v 1.1 2003/06/23 16:36:29 mcummings Exp $

inherit perl-module

MY_P=Convert-PEM-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Read/write encrypted ASN.1 PEM files"
SRC_URI="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~alpha ~ppc ~sparc"

DEPEND="dev-perl/MIME-Base64
		dev-perl/Convert-ASN1
		dev-perl/Digest-MD5
		dev-perl/crypt-des-ede3"
