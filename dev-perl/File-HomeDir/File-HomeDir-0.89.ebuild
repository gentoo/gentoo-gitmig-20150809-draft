# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-HomeDir/File-HomeDir-0.89.ebuild,v 1.4 2010/06/27 19:10:15 nixnut Exp $

EAPI=2

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Get home directory for self or other user"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86 ~x86-fbsd ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-File-Spec"
DEPEND="${RDEPEND}"

SRC_TEST="do"
