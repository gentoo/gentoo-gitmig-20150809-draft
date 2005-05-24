# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-ssh-perl/net-ssh-perl-1.25.ebuild,v 1.6 2005/05/24 15:51:43 mcummings Exp $

inherit perl-module

MY_P=Net-SSH-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl client Interface to SSH"
HOMEPAGE="http://search.cpan.org/~drolsky/${MY_P}.tar.gz"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${MY_P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~alpha ~ppc ~sparc ~mips"
IUSE=""

DEPEND="dev-perl/Math-GMP
		dev-perl/string-crc32
		dev-perl/math-pari
		perl-core/Digest-MD5
		dev-perl/Digest-SHA1
		dev-perl/Digest-HMAC
		dev-perl/crypt-dh
		dev-perl/crypt-dsa
		dev-perl/math-pari
		dev-perl/MIME-Base64
		dev-perl/convert-pem
		dev-perl/Crypt-Blowfish
		dev-perl/Crypt-DES
		dev-perl/crypt-idea
		dev-perl/Crypt-OpenSSL-RSA
		dev-perl/crypt-rsa
		dev-perl/digest-bubblebabble"

src_compile() {
	echo "" | perl-module_src_compile
}
