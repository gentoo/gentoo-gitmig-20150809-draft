# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Amazon/Net-Amazon-0.50.ebuild,v 1.2 2009/05/03 18:00:19 maekke Exp $

MODULE_AUTHOR=BOUMENOT

inherit perl-module

DESCRIPTION="Net::Amazon - Framework for accessing amazon.com via SOAP and XML/HTTP"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ~x86"
SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
	>=dev-perl/XML-Simple-2.08
	>=virtual/perl-Time-HiRes-1.0
	>=dev-perl/Log-Log4perl-0.3
	dev-perl/URI
	dev-lang/perl"
