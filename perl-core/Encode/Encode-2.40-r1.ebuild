# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Encode/Encode-2.40-r1.ebuild,v 1.3 2011/01/02 22:26:17 hwoarang Exp $

EAPI=3

MODULE_AUTHOR=DANKOGAI
inherit perl-module

DESCRIPTION="character encodings"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="!!<dev-lang/perl-5.8.8-r8"

SRC_TEST=do
PATCHES=( "${FILESDIR}"/gentoo_enc2xs.diff )
