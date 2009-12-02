# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Encode/Encode-2.39.ebuild,v 1.1 2009/12/02 15:25:45 tove Exp $

EAPI=2

MODULE_AUTHOR=DANKOGAI
inherit perl-module

DESCRIPTION="character encodings"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!!<dev-lang/perl-5.8.8-r8"

SRC_TEST=do
