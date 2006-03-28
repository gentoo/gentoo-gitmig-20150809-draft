# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/beancounter/beancounter-0.8.6.ebuild,v 1.1 2006/03/28 10:52:22 satya Exp $

inherit perl-app

DESCRIPTION="Finance performance calculation engine with full data acquisition and SQL backend support"
HOMEPAGE="http://dirk.eddelbuettel.com/code/beancounter.html"
SRC_URI="http://eddelbuettel.com/dirk/code/beancounter/beancounter_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="mysql postgres sqlite"

DEPEND=">=dev-lang/perl-5
	dev-perl/DateManip
	dev-perl/Statistics-Descriptive
	dev-perl/Finance-YahooQuote
	dev-perl/libwww-perl
	mysql? ( dev-perl/DBD-mysql )
	sqlite? ( dev-perl/DBD-SQLite )
	postgres? ( dev-perl/DBD-Pg )"

mydoc="BUGS THANKS TODO example.* *.txt"
