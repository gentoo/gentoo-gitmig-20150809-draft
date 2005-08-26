# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/convert-pem/convert-pem-0.06.ebuild,v 1.15 2005/08/26 02:39:33 agriffis Exp $

inherit perl-module

MY_P=Convert-PEM-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Read/write encrypted ASN.1 PEM files"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/B/BT/BTROTT/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="perl-core/MIME-Base64
	dev-perl/Convert-ASN1
	perl-core/Digest-MD5
	dev-perl/crypt-des-ede3"
