# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/quickcrypt/quickcrypt-0.9.2b.ebuild,v 1.2 2003/09/07 23:46:18 lanius Exp $

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
