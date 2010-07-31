# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-Command/ExtUtils-Command-1.16.ebuild,v 1.7 2010/07/31 22:53:02 hwoarang Exp $

EAPI="2"

MODULE_AUTHOR=RKOBES
inherit perl-module

DESCRIPTION="Utilities to replace common UNIX commands in Makefiles etc."

SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~sparc x86"
IUSE=""

SRC_TEST=do
PREFER_BUILDPL=no
