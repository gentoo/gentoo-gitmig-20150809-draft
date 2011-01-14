# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-AutoWriter/XML-AutoWriter-0.400.ebuild,v 1.1 2011/01/14 13:54:40 tove Exp $

MODULE_AUTHOR=PERIGRIN
MODULE_VERSION=0.4
inherit perl-module

DESCRIPTION="DOCTYPE based XML output"
IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="amd64 hppa ia64 sparc x86"

DEPEND="dev-perl/XML-Parser
	dev-lang/perl"

SRC_TEST="do"
