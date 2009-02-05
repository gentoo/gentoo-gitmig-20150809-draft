# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/net-ssh-perl/net-ssh-perl-1.34.ebuild,v 1.1 2009/02/05 13:19:13 tove Exp $

MODULE_AUTHOR=TURNSTEP
MY_PN=Net-SSH-Perl
MY_P=${MY_PN}-${PV}
inherit perl-module

DESCRIPTION="Perl client Interface to SSH"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~sparc ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND="dev-lang/perl
	virtual/perl-Digest-MD5
	>=dev-perl/string-crc32-1.2
	>=dev-perl/Math-GMP-1.04
	>=dev-perl/math-pari-2.001804
	>=dev-perl/Digest-SHA1-2.10
	dev-perl/Digest-HMAC
	dev-perl/crypt-dh
	>=dev-perl/crypt-dsa-0.11
	virtual/perl-MIME-Base64
	>=dev-perl/convert-pem-0.05
	dev-perl/Crypt-Blowfish
	dev-perl/Crypt-DES
	dev-perl/crypt-idea
	dev-perl/Crypt-OpenSSL-RSA
	dev-perl/crypt-rsa
	dev-perl/digest-bubblebabble
	dev-lang/perl"

#src_compile() {
#	echo "" | perl-module_src_compile
#}
SRC_TEST=do
