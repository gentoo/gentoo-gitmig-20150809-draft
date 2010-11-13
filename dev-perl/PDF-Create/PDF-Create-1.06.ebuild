# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDF-Create/PDF-Create-1.06.ebuild,v 1.4 2010/11/13 19:47:36 armin76 Exp $

EAPI=2

MODULE_AUTHOR=MARKUSB
inherit perl-module

DESCRIPTION="PDF::Create allows you to create PDF documents"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

RDEPEND=""
DEPEND="virtual/perl-Module-Build"

SRC_TEST=do
