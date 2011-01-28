# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/JSON-PP/JSON-PP-2.271.40.ebuild,v 1.1 2011/01/28 08:03:34 tove Exp $

EAPI=3

MODULE_AUTHOR=MAKAMAKA
MODULE_VERSION=2.27104
inherit perl-module

DESCRIPTION="JSON::XS compatible pure-Perl module"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!!<dev-perl/JSON-2.50"

SRC_TEST="do"
