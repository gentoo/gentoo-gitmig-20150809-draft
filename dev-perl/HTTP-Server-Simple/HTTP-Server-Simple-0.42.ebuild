# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Server-Simple/HTTP-Server-Simple-0.42.ebuild,v 1.2 2010/04/17 08:43:50 tove Exp $

EAPI=2

#MODULE_AUTHOR=ALEXMV
MODULE_AUTHOR=JESSE
inherit perl-module eutils

DESCRIPTION="Lightweight HTTP Server"

SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
#PATCHES=( "${FILESDIR}/${PV}-debian.patch" )
