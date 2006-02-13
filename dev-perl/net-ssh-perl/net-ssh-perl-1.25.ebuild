# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-ssh-perl/net-ssh-perl-1.25.ebuild,v 1.9 2006/02/13 14:24:31 mcummings Exp $

inherit perl-module

MY_P=Net-SSH-Perl-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl client Interface to SSH"
HOMEPAGE="http://search.cpan.org/~drolsky/${MY_P}.tar.gz"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${MY_P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha ~mips ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-perl/Math-GMP
		dev-perl/string-crc32
		dev-perl/math-pari
		virtual/perl-Digest-MD5
		dev-perl/Digest-SHA1
		dev-perl/Digest-HMAC
		dev-perl/crypt-dh
		dev-perl/crypt-dsa
		dev-perl/math-pari
		virtual/perl-MIME-Base64
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
