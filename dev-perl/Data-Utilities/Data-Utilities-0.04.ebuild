# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Utilities/Data-Utilities-0.04.ebuild,v 1.2 2009/09/28 06:59:02 tove Exp $

EAPI="2"

MODULE_AUTHOR=CORNELIS
inherit perl-module

DESCRIPTION="Merge nested Perl data structures"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Clone"
RDEPEND="${DEPEND}"

SRC_TEST=do
PREFER_BUILDPL=no
