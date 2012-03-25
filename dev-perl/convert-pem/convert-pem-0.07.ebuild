# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/convert-pem/convert-pem-0.07.ebuild,v 1.20 2012/03/25 17:29:27 armin76 Exp $

inherit perl-module

MY_PN=Convert-PEM
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Read/write encrypted ASN.1 PEM files"
HOMEPAGE="http://search.cpan.org/~btrott/"
SRC_URI="mirror://cpan/authors/id/B/BT/BTROTT/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ~ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="virtual/perl-MIME-Base64
	dev-perl/Convert-ASN1
	virtual/perl-Digest-MD5
	dev-perl/Class-ErrorHandler
	dev-perl/crypt-des-ede3
	dev-lang/perl"
