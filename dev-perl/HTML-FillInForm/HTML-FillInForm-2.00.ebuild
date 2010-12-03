# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-FillInForm/HTML-FillInForm-2.00.ebuild,v 1.6 2010/12/03 00:49:39 xmw Exp $

EAPI=2

MODULE_AUTHOR=TJMATHER
inherit perl-module

DESCRIPTION="Populates HTML Forms with data."

SLOT="0"
KEYWORDS="amd64 ~arm ia64 ~ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-perl/HTML-Parser"
DEPEND="${RDEPEND}"

SRC_TEST="do"
