# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-ParseWords/Text-ParseWords-3.270.ebuild,v 1.1 2011/02/18 07:04:37 tove Exp $

EAPI=3

MODULE_AUTHOR=CHORNY
MODULE_VERSION=3.27
MODULE_A_EXT=zip
inherit perl-module

DESCRIPTION="Parse text into an array of tokens or array of arrays"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/unzip"

SRC_TEST="do"
