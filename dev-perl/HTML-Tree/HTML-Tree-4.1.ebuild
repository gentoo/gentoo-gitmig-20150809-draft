# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Tree/HTML-Tree-4.1.ebuild,v 1.1 2010/10/27 19:09:56 tove Exp $

EAPI=3

MODULE_AUTHOR=JFEARN
inherit perl-module

DESCRIPTION="A library to manage HTML-Tree in PERL"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-perl/HTML-Tagset-3.03
	>=dev-perl/HTML-Parser-3.46"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Exception )"

SRC_TEST="do"
