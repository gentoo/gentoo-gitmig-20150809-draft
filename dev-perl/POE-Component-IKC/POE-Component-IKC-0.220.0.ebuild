# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE-Component-IKC/POE-Component-IKC-0.220.0.ebuild,v 1.1 2011/02/26 09:43:41 tove Exp $

EAPI=2

MODULE_AUTHOR="GWYN"
MODULE_VERSION=0.2200
inherit perl-module

DESCRIPTION="POE Inter-Kernel Communication"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/POE-API-Peek-1.34
	dev-perl/POE"
RDEPEND="${DEPEND}"
