# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-SmbHash/Crypt-SmbHash-0.120.0.ebuild,v 1.1 2011/08/31 13:49:44 tove Exp $

EAPI=4

MODULE_AUTHOR=BJKUIT
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="LM/NT hashing, for Samba's smbpasswd entries"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Digest-MD4"
DEPEND="${RDEPEND}"
