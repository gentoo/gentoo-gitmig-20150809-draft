# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-FillInForm/HTML-FillInForm-2.0.0.ebuild,v 1.2 2011/09/03 21:04:53 tove Exp $

EAPI=4

MODULE_AUTHOR=TJMATHER
MODULE_VERSION=2.00
inherit perl-module

DESCRIPTION="Populates HTML Forms with data."

SLOT="0"
KEYWORDS="amd64 ~arm ia64 ~ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-perl/HTML-Parser"
DEPEND="${RDEPEND}"

SRC_TEST="do"
