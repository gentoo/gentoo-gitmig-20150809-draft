# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME/Email-MIME-1.905.ebuild,v 1.1 2010/09/09 05:35:02 tove Exp $

EAPI=3

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Easy MIME message parsing"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~sparc-solaris ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/Email-MessageID
	>=dev-perl/Email-MIME-Encodings-1.310
	>=dev-perl/Email-MIME-ContentType-1.012
	>=dev-perl/Email-Simple-2.100
	>=dev-perl/MIME-Types-1.18
	!dev-perl/Email-MIME-Modifier
	!dev-perl/Email-MIME-Creator"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
