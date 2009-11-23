# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBI-Shell/DBI-Shell-11.95.ebuild,v 1.2 2009/11/23 17:23:01 tove Exp $

EAPI=2

MODULE_AUTHOR=TLOWERY
inherit perl-module

DESCRIPTION="Interactive command shell for the DBI"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/IO-Tee
	dev-perl/text-reform
	dev-perl/DBI
	dev-perl/Text-CSV_XS"
DEPEND="${RDEPEND}"

SRC_TEST="do"
