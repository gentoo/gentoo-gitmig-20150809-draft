# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Aligner/Text-Aligner-0.06.ebuild,v 1.1 2010/08/29 10:59:34 tove Exp $

EAPI="3"

MODULE_AUTHOR="ANNO"
inherit perl-module

DESCRIPTION="Used to justify strings to various alignment styles"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/perl-Term-ANSIColor-2.01"
DEPEND="${RDEPEND}"

SRC_TEST="do"
