# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Simple/Email-Simple-2.100.ebuild,v 1.7 2010/03/04 19:03:23 armin76 Exp $

EAPI=2

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Simple parsing of RFC2822 message format and headers"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="test"

RDEPEND="dev-perl/Email-Date-Format"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		virtual/perl-Test-Simple )"
RDEPEND="${RDEPEND}
	!dev-perl/Email-Simple-Creator"

SRC_TEST="do"
