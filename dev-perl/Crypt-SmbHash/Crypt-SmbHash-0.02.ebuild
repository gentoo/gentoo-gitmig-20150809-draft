# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-SmbHash/Crypt-SmbHash-0.02.ebuild,v 1.1 2003/08/14 02:41:09 robbat2 Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="LM/NT hashing, for Samba's smbpasswd entries"
AUTHOR="BJKUIT"
BASE_URI="http://www.cpan.org/modules/by-authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}"
SRC_URI="${BASE_URI}/${P}.tar.gz"
HOMEPAGE="${BASE_URI}/${P}.readme"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="dev-perl/Digest-MD4"

