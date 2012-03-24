# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Zip/Archive-Zip-1.300.0.ebuild,v 1.3 2012/03/24 15:06:40 grobian Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.30
inherit perl-module

DESCRIPTION="A wrapper that lets you read Zip archive members as if they were files"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=">=virtual/perl-Compress-Raw-Zlib-2.017
	>=virtual/perl-File-Spec-0.80"
RDEPEND="${DEPEND}"

SRC_TEST="do"
