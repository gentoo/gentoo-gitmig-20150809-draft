# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-SmbHash/Crypt-SmbHash-0.02.ebuild,v 1.6 2004/07/28 04:57:53 kumba Exp $

inherit perl-module

DESCRIPTION="LM/NT hashing, for Samba's smbpasswd entries"
AUTHOR="BJKUIT"
BASE_URI="http://www.cpan.org/modules/by-authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}"
SRC_URI="${BASE_URI}/${P}.tar.gz"
HOMEPAGE="${BASE_URI}/${P}.readme"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc mips"
IUSE=""

DEPEND="dev-perl/Digest-MD4"
