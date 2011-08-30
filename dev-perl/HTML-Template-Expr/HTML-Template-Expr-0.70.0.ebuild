# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Template-Expr/HTML-Template-Expr-0.70.0.ebuild,v 1.1 2011/08/30 13:51:55 tove Exp $

EAPI=4

MODULE_AUTHOR=SAMTREGAR
MODULE_VERSION=0.07
inherit perl-module

DESCRIPTION="HTML::Template extension adding expression support"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-perl/HTML-Template-2.8
	dev-perl/Parse-RecDescent"
DEPEND="${RDEPEND}"

SRC_TEST="do"
