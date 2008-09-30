# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Generator/XML-Generator-1.01.ebuild,v 1.8 2008/09/30 15:27:58 tove Exp $

MODULE_AUTHOR=BHOLZMAN
inherit perl-module

DESCRIPTION="Perl XML::Generator - A module to help in generating XML documents"

LICENSE="|| ( GPL-2 Artistic )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-libs/expat
	dev-lang/perl"
RDEPEND="${DEPEND}"
