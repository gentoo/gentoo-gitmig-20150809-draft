# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-TokeParser-Simple/HTML-TokeParser-Simple-3.15.ebuild,v 1.15 2011/07/29 22:24:28 zmedico Exp $

EAPI=2

MODULE_AUTHOR=OVID
inherit perl-module

DESCRIPTION="A bare-bones HTML parser, similar to HTML::Parser, but with a couple important distinctions."

SLOT="0"
KEYWORDS="amd64 ia64 ppc ~ppc64 sparc x86 ~x86-linux"
IUSE=""

RDEPEND=">=dev-perl/HTML-Parser-3.25"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	virtual/perl-Test-Simple
	dev-perl/Sub-Override"

SRC_TEST="do"
