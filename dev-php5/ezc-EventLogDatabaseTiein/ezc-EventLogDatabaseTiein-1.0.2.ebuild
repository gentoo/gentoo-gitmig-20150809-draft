# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-EventLogDatabaseTiein/ezc-EventLogDatabaseTiein-1.0.2.ebuild,v 1.4 2008/01/13 16:03:12 jokey Exp $

EZC_BASE_MIN="1.2"
inherit php-ezc

DESCRIPTION="This eZ component contains the database writer backend for the EventLog component."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""
RDEPEND="${RDEPEND}
	>=dev-php5/ezc-Database-1.2
	>=dev-php5/ezc-EventLog-1.0.3"
