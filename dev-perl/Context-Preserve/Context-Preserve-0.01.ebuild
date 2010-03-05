# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Context-Preserve/Context-Preserve-0.01.ebuild,v 1.1 2010/03/05 08:10:47 tove Exp $

EAPI=2

MODULE_AUTHOR=JROCKWAY
inherit perl-module

DESCRIPTION="Pass chained return values from subs, modifying their values, without losing context."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Exception )"

SRC_TEST="do"
