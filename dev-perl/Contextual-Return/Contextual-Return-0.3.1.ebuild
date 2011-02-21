# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Contextual-Return/Contextual-Return-0.3.1.ebuild,v 1.1 2011/02/21 11:00:44 tove Exp $

EAPI=3

MODULE_AUTHOR=DCONWAY
MODULE_VERSION=0.003001
inherit perl-module

DESCRIPTION="Create context-senstive return values"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Want
	virtual/perl-version"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
