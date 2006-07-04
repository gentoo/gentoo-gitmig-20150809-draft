# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-SmbHash/Crypt-SmbHash-0.02.ebuild,v 1.15 2006/07/04 07:07:15 ian Exp $

inherit perl-module

AUTHOR="BJKUIT"
BASE_URI="http://www.cpan.org/modules/by-authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}"
DESCRIPTION="LM/NT hashing, for Samba's smbpasswd entries"
SRC_URI="${BASE_URI}/${P}.tar.gz"
HOMEPAGE="${BASE_URI}/${P}.readme"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha arm amd64 hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="dev-perl/Digest-MD4"
RDEPEND="${DEPEND}"