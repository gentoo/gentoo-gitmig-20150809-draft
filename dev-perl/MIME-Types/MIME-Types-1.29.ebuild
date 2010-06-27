# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-Types/MIME-Types-1.29.ebuild,v 1.6 2010/06/27 19:13:42 nixnut Exp $

EAPI=2

MODULE_AUTHOR=MARKOV
inherit perl-module

DESCRIPTION="Definition of MIME types"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86 ~x86-fbsd ~sparc-solaris ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
