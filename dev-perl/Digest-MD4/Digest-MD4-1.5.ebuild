# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD4/Digest-MD4-1.5.ebuild,v 1.13 2010/01/21 13:20:47 tove Exp $

EAPI=2

MODULE_SECTION=DigestMD4
MODULE_AUTHOR=MIKEM
inherit perl-module

DESCRIPTION="MD4 message digest algorithm"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

SRC_TEST="do"
