# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Astro-FITS-Header/Astro-FITS-Header-3.30.0.ebuild,v 1.7 2012/03/08 11:57:05 phajdan.jr Exp $

EAPI=4

MODULE_AUTHOR=TJENNESS
MODULE_VERSION=3.03
inherit perl-module

DESCRIPTION="Interface to FITS headers"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~mips ppc ~s390 ~sh ~sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
