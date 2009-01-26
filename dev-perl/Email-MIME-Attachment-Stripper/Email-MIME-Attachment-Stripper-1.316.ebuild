# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME-Attachment-Stripper/Email-MIME-Attachment-Stripper-1.316.ebuild,v 1.1 2009/01/26 11:37:26 tove Exp $

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Strip the attachments from a mail"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND="dev-lang/perl
	>=dev-perl/Email-MIME-1.861
	>=dev-perl/Email-MIME-Modifier-1.442
	>=dev-perl/Email-MIME-ContentType-1.012"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
