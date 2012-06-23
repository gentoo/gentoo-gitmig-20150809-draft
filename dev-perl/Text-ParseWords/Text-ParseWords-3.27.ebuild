# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-ParseWords/Text-ParseWords-3.27.ebuild,v 1.1 2012/06/23 23:58:29 cardoe Exp $

EAPI=4

MODULE_AUTHOR="CHORNY"
MODULE_A_EXT="zip"

inherit perl-module

DESCRIPTION="Parse strings containing shell-style quoting"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
