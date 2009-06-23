# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXML-Iterator/XML-LibXML-Iterator-1.04.ebuild,v 1.4 2009/06/23 10:56:29 tove Exp $

MODULE_AUTHOR=PHISH
inherit perl-module

DESCRIPTION="Iterator class for XML::LibXML parsed documents"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86"
IUSE=""

DEPEND="dev-perl/XML-LibXML
	dev-perl/XML-NodeFilter
	dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"
