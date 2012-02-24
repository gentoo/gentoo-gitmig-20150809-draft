# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/inline-files/inline-files-0.680.0.ebuild,v 1.2 2012/02/24 10:52:21 ago Exp $

EAPI=4

MY_PN=Inline-Files
MODULE_AUTHOR=AMBS
MODULE_SECTION=Inline
MODULE_VERSION=0.68
inherit perl-module

DESCRIPTION="Multiple virtual files in a single file"

SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST=do
