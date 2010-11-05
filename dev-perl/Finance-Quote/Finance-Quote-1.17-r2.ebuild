# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Finance-Quote/Finance-Quote-1.17-r2.ebuild,v 1.2 2010/11/05 15:33:29 halcy0n Exp $

EAPI=3

MODULE_AUTHOR=ECOCODE
inherit perl-module

DESCRIPTION="Get stock and mutual fund quotes from various exchanges"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	dev-perl/HTML-Tree
	dev-perl/HTML-TableExtract
	dev-perl/Crypt-SSLeay"
RDEPEND="${DEPEND}"

SRC_TEST="do"
mydoc="TODO"
PATCHES=( "${FILESDIR}"/VWD.pm.diff )
