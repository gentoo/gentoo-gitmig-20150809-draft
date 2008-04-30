# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Amazon/Net-Amazon-0.49.ebuild,v 1.1 2008/04/30 08:50:22 tove Exp $

MODULE_AUTHOR=BOUMENOT

inherit perl-module

DESCRIPTION="Net::Amazon - Framework for accessing amazon.com via SOAP and XML/HTTP"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"
SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
	>=dev-perl/XML-Simple-2.08
	>=virtual/perl-Time-HiRes-1.0
	>=dev-perl/Log-Log4perl-0.3
	dev-perl/URI
	dev-lang/perl"
