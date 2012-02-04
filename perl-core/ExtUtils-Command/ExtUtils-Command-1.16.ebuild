# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-Command/ExtUtils-Command-1.16.ebuild,v 1.10 2012/02/04 15:37:05 armin76 Exp $

EAPI="2"

MODULE_AUTHOR=RKOBES
inherit perl-module

DESCRIPTION="Utilities to replace common UNIX commands in Makefiles etc."

SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ~s390 ~sh sparc x86"
IUSE=""

SRC_TEST=do
PREFER_BUILDPL=no
