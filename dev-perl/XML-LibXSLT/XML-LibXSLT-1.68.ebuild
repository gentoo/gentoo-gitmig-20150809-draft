# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXSLT/XML-LibXSLT-1.68.ebuild,v 1.1 2008/11/21 09:43:13 tove Exp $

MODULE_AUTHOR=PAJAS
inherit perl-module

DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-libs/libxslt-1.1.8
	>=dev-perl/XML-LibXML-1.67
	dev-lang/perl"
