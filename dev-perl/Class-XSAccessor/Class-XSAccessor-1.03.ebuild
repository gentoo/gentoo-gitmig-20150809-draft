# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-XSAccessor/Class-XSAccessor-1.03.ebuild,v 1.1 2009/10/06 19:02:05 tove Exp $

EAPI=2

MODULE_AUTHOR=SMUELLER
inherit perl-module

DESCRIPTION="Generate fast XS accessors without runtime compilation"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/AutoXS-Header-1.01"
RDEPEND="${DEPEND}"

SRC_TEST=do
