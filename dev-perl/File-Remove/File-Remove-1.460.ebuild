# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Remove/File-Remove-1.460.ebuild,v 1.1 2011/02/18 06:29:12 tove Exp $

EAPI=3

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.46
inherit perl-module

DESCRIPTION="Remove files and directories"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND=">=virtual/perl-File-Spec-0.84"
DEPEND="${RDEPEND}"

SRC_TEST="do"
