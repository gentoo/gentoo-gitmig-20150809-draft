# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/inline-files/inline-files-0.63.ebuild,v 1.1 2009/05/11 10:51:02 tove Exp $

EAPI=2

MODULE_AUTHOR=AMBS
MODULE_SECTION=Inline
MY_PN=Inline-Files
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Multiple virtual files in a single file"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST=do
