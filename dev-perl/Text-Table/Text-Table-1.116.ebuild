# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Table/Text-Table-1.116.ebuild,v 1.1 2010/08/29 11:01:03 tove Exp $

EAPI="3"

MODULE_AUTHOR="ANNO"
inherit perl-module

DESCRIPTION="Organize Data in Tables"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/Text-Aligner-0.05"
DEPEND="${RDEPEND}"

SRC_TEST="do"
