# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/ExtUtils-Manifest/ExtUtils-Manifest-1.580.0.ebuild,v 1.2 2011/07/26 18:21:50 xarthisius Exp $

EAPI=2

MODULE_AUTHOR=RKOBES
MODULE_VERSION=1.58
inherit perl-module

DESCRIPTION="Utilities to write and check a MANIFEST file"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"
PREFER_BUILDPL="no"
