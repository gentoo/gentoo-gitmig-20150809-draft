# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME-Creator/Email-MIME-Creator-1.456.ebuild,v 1.1 2009/05/01 10:53:14 tove Exp $

EAPI=2

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Email::MIME constructor for starting anew"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/Email-Simple-Creator-1.41
	>=dev-perl/Email-MIME-1.857
	>=dev-perl/Email-MIME-Encodings-1.313
	>=dev-perl/Email-MIME-Modifier-1.441
	dev-perl/Email-Simple"

SRC_TEST="do"
