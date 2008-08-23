# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MIME-Attachment-Stripper/Email-MIME-Attachment-Stripper-1.315.ebuild,v 1.1 2008/08/23 19:17:22 tove Exp $

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Strip the attachments from a mail"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/Email-MIME-1.861
	>=dev-perl/Email-MIME-Modifier-1.442
	>=dev-perl/Email-MIME-ContentType-1.012
	dev-lang/perl"

SRC_TEST="do"
