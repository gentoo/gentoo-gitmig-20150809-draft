# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Audit/Mail-Audit-2.223.ebuild,v 1.1 2008/09/30 06:14:32 robbat2 Exp $

MODULE_AUTHOR="RJBS"
inherit perl-module

DESCRIPTION="Mail sorting/delivery module for Perl."

LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SLOT="0"
DEPEND="dev-perl/MIME-tools
	>=dev-perl/MailTools-1.15
	virtual/perl-libnet
	dev-perl/File-Tempdir
	>=dev-perl/File-HomeDir-0.61
	dev-lang/perl"
