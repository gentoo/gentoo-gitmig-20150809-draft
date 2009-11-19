# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME-Creator/Email-MIME-Creator-1.454.ebuild,v 1.5 2009/11/19 07:43:10 tove Exp $

EAPI=2

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Email::MIME constructor for starting anew"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="
	|| ( >=dev-perl/Email-Simple-2.100 >=dev-perl/Email-Simple-Creator-1.41 )
	virtual/perl-Test-Simple
	>=dev-perl/Email-MIME-1.857
	|| ( >=dev-perl/Email-MIME-1.900 >=dev-perl/Email-MIME-Modifier-1.441 )
	dev-perl/Email-Simple"
DEPEND="${RDEPEND}"

SRC_TEST="do"
