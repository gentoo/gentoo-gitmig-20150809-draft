# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SMTP-SSL/Net-SMTP-SSL-1.01.ebuild,v 1.1 2008/03/17 08:14:16 robbat2 Exp $

MODULE_AUTHOR="CWEST"
inherit perl-module

DESCRIPTION="SSL support for Net::SMTP"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-lang/perl"

mydoc="Changes README"
# testsuite requires gearman server
#SRC_TEST="never"
