# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/string-crc32/string-crc32-1.400.0.ebuild,v 1.1 2011/08/27 16:44:16 tove Exp $

EAPI=4

MY_PN=String-CRC32
MODULE_AUTHOR=SOENKE
MODULE_VERSION=1.4
inherit perl-module

DESCRIPTION="Perl interface for cyclic redundancy check generation"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

SRC_TEST=do
