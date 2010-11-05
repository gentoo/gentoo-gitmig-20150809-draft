# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Validate/Params-Validate-0.95.ebuild,v 1.5 2010/11/05 14:01:00 ssuominen Exp $

EAPI=2

MODULE_AUTHOR=DROLSKY
inherit perl-module

DESCRIPTION="A module to provide a flexible system for validation method/function call parameters"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-Attribute-Handlers"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.35"

SRC_TEST="do"
