# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RSS-Feed/XML-RSS-Feed-2.320.0.ebuild,v 1.1 2011/08/28 06:25:33 tove Exp $

EAPI=4

MODULE_AUTHOR=JBISBEE
MODULE_VERSION=2.32
inherit perl-module

DESCRIPTION="Persistant XML RSS Encapsulation"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE="test"

RDEPEND="dev-perl/HTML-Parser
	dev-perl/XML-RSS
	dev-perl/Clone
	virtual/perl-Time-HiRes
	dev-perl/URI
	virtual/perl-Digest-MD5"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
