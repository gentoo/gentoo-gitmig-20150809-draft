# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Statement/SQL-Statement-1.25.ebuild,v 1.4 2010/12/03 02:09:46 xmw Exp $

EAPI=2

MODULE_AUTHOR=REHSACK
inherit perl-module

DESCRIPTION="Small SQL parser and engine"

SLOT="0"
KEYWORDS="amd64 ~arm ia64 sparc x86"
IUSE=""

RDEPEND="
	>=dev-perl/Clone-0.30
	>=dev-perl/Params-Util-0.35
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}"

SRC_TEST="do"

pkg_setup() {
	export SQL_STATEMENT_WARN_UPDATE=sure

	if has_version "<=dev-perl/SQL-Statement-1.20" ; then
		ewarn "Changes include (1.22):"
		ewarn "  * behavior for unquoted identifiers modified to lower case them"
		ewarn "  * IN and BETWEEN operators are supported native"
	fi
}
