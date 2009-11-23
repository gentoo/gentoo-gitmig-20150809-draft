# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Contextual-Return/Contextual-Return-0.2.1.ebuild,v 1.2 2009/11/23 16:57:09 tove Exp $

EAPI=2

MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"
MODULE_AUTHOR="DCONWAY"
inherit perl-module

DESCRIPTION="Create context-senstive return values"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Want
	virtual/perl-version"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

S="${WORKDIR}/${MY_P}"
