# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/inline-files/inline-files-0.640.ebuild,v 1.1 2011/02/02 18:46:21 tove Exp $

EAPI=3

MY_PN=Inline-Files
MODULE_AUTHOR=AMBS
MODULE_SECTION=Inline
MODULE_VERSION=0.64
inherit perl-module

DESCRIPTION="Multiple virtual files in a single file"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST=do
