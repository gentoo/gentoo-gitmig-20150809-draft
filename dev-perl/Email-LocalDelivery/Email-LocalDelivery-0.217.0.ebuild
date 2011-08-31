# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-LocalDelivery/Email-LocalDelivery-0.217.0.ebuild,v 1.1 2011/08/31 10:58:07 tove Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.217
inherit perl-module

DESCRIPTION="Local delivery of RFC2822 message format and headers"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND="dev-perl/Email-Simple
	dev-perl/Email-FolderType
	dev-perl/File-Path-Expand"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
