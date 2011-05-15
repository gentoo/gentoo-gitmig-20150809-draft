# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Encode/Encode-2.40-r1.ebuild,v 1.5 2011/05/15 18:32:30 armin76 Exp $

EAPI=3

MODULE_AUTHOR=DANKOGAI
inherit perl-module

DESCRIPTION="character encodings"

SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~m68k ~s390 ~sh ~sparc x86"
IUSE=""

RDEPEND="!!<dev-lang/perl-5.8.8-r8"

SRC_TEST=do
PATCHES=( "${FILESDIR}"/gentoo_enc2xs.diff )
