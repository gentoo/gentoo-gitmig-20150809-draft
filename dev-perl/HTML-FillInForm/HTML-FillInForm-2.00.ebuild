# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-FillInForm/HTML-FillInForm-2.00.ebuild,v 1.4 2009/05/08 18:18:54 tove Exp $

MODULE_AUTHOR=TJMATHER
inherit perl-module

DESCRIPTION="Populates HTML Forms with data."

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/HTML-Parser
	dev-lang/perl"
