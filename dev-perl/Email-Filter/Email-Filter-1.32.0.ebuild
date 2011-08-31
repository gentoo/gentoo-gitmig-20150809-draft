# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Filter/Email-Filter-1.32.0.ebuild,v 1.1 2011/08/31 11:03:10 tove Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=1.032
inherit perl-module

DESCRIPTION="Simple filtering of RFC2822 message format and headers"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Email-LocalDelivery
	dev-perl/Class-Trigger
	dev-perl/IPC-Run
	dev-perl/Email-Simple"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
