# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LWP-MediaTypes/LWP-MediaTypes-6.10.0.ebuild,v 1.3 2011/04/08 16:06:27 maekke Exp $

EAPI=3

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.01
inherit perl-module

DESCRIPTION="Media types and mailcap processing"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
"
DEPEND="${RDEPEND}"

SRC_TEST=do
