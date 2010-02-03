# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-FillInForm/HTML-FillInForm-2.00.ebuild,v 1.5 2010/02/03 14:38:38 tove Exp $

EAPI=2

MODULE_AUTHOR=TJMATHER
inherit perl-module

DESCRIPTION="Populates HTML Forms with data."

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-perl/HTML-Parser"
DEPEND="${RDEPEND}"

SRC_TEST="do"
