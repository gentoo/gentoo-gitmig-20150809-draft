# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Valid/Email-Valid-0.190.0.ebuild,v 1.1 2012/03/29 18:08:27 tove Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.190
inherit perl-module

DESCRIPTION="Check validity of Internet email addresses."

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND="
	dev-perl/MailTools
"
DEPEND="
	test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
PATCHES=( "${FILESDIR}/0.185-disable-online-test.patch" )
