# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Context-Preserve/Context-Preserve-0.01.ebuild,v 1.3 2011/04/24 15:46:50 grobian Exp $

EAPI=2

MODULE_AUTHOR=JROCKWAY
inherit perl-module

DESCRIPTION="Pass chained return values from subs, modifying their values, without losing context."

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Exception
		dev-perl/Test-use-ok )"

SRC_TEST="do"
