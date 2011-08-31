# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBI-Shell/DBI-Shell-11.950.0.ebuild,v 1.1 2011/08/31 13:43:56 tove Exp $

EAPI=4

MODULE_AUTHOR=TLOWERY
MODULE_VERSION=11.95
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
