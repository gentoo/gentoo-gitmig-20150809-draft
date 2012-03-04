# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Contextual-Return/Contextual-Return-0.4.2.ebuild,v 1.1 2012/03/04 17:59:32 tove Exp $

EAPI=4

MODULE_AUTHOR=DCONWAY
MODULE_VERSION=0.004002
inherit perl-module

DESCRIPTION="Create context-senstive return values"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/Want
	virtual/perl-version
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
"

SRC_TEST=do
