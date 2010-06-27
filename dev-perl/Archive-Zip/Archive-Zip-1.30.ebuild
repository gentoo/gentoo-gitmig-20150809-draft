# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Zip/Archive-Zip-1.30.ebuild,v 1.7 2010/06/27 18:58:38 nixnut Exp $

EAPI=2

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="A wrapper that lets you read Zip archive members as if they were files"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=">=virtual/perl-Compress-Raw-Zlib-2.017
	>=virtual/perl-File-Spec-0.80"
RDEPEND="${DEPEND}"

SRC_TEST="do"
