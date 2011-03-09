# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LWP-MediaTypes/LWP-MediaTypes-6.10.0.ebuild,v 1.1 2011/03/09 12:35:35 tove Exp $

EAPI=3

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.01
inherit perl-module

DESCRIPTION="Media types and mailcap processing"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
"
DEPEND="${RDEPEND}"

SRC_TEST=do
