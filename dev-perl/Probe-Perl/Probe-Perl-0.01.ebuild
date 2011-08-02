# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Probe-Perl/Probe-Perl-0.01.ebuild,v 1.11 2011/08/02 06:08:27 mattst88 Exp $

EAPI=2

MODULE_AUTHOR=KWILLIAMS
inherit perl-module

DESCRIPTION="Information about the currently running perl"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
