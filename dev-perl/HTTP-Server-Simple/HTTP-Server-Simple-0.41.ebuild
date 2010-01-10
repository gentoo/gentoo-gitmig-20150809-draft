# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Server-Simple/HTTP-Server-Simple-0.41.ebuild,v 1.2 2010/01/10 12:44:01 grobian Exp $

#MODULE_AUTHOR=ALEXMV
MODULE_AUTHOR=JESSE
inherit perl-module eutils

DESCRIPTION="Lightweight HTTP Server"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND="dev-lang/perl
	dev-perl/URI"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
#PATCHES=( "${FILESDIR}/${PV}-debian.patch" )
