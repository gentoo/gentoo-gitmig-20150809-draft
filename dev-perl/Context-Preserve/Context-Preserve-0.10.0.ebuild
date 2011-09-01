# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Context-Preserve/Context-Preserve-0.10.0.ebuild,v 1.1 2011/09/01 10:42:47 tove Exp $

EAPI=4

MODULE_AUTHOR=JROCKWAY
MODULE_VERSION=0.01
inherit perl-module

DESCRIPTION="Pass chained return values from subs, modifying their values, without losing context."

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Exception
		dev-perl/Test-use-ok
	)"

SRC_TEST="do"
