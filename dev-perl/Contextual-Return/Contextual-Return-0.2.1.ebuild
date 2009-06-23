# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Contextual-Return/Contextual-Return-0.2.1.ebuild,v 1.1 2009/06/23 07:35:41 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="DCONWAY"
MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"

inherit perl-module

DESCRIPTION="Create context-senstive return values"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Want"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
