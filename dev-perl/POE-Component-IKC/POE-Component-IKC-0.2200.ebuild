# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE-Component-IKC/POE-Component-IKC-0.2200.ebuild,v 1.2 2009/06/23 08:44:51 tove Exp $

EAPI=2

MODULE_AUTHOR="GWYN"
inherit perl-module

DESCRIPTION="POE Inter-Kernel Communication"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/POE-API-Peek-1.34
	dev-perl/POE"
RDEPEND="${DEPEND}"
