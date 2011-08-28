# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-Latex/Template-Latex-2.170.0.ebuild,v 1.1 2011/08/28 18:20:51 tove Exp $

EAPI=4

MODULE_AUTHOR=ANDREWF
MODULE_VERSION=2.17
inherit perl-module eutils

DESCRIPTION="Template::Latex - Latex support for the Template Toolkit"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-perl/Template-Toolkit-2.15
	virtual/perl-File-Spec
	virtual/latex-base"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Harness )"

SRC_TEST="do"
PATCHES=( "${FILESDIR}/Makefile.patch" )
