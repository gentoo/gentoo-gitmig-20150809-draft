# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

MY_P=${P/-/_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="QuickCrypt - Gives you a quick MD5 Password from any string"
HOMEPAGE="http://linux.netpimpz.com/quickcrypt/"
DEPEND=">=dev-lang/perl-5.6*
		dev-perl/Digest-MD5"
SRC_URI="http://linux.netpimpz.com/quickcrypt/download/${MY_P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

src_install () {
	dobin quickcrypt
	dodoc README BUGS LICENSE
}
