# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-AuthenticationDatabaseTiein/ezc-AuthenticationDatabaseTiein-1.1.ebuild,v 1.1 2008/01/13 15:59:34 jokey Exp $

EZC_BASE_MIN="1.4"
inherit php-ezc

DESCRIPTION="This eZ component contains database writer backend for the Authentication component."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php5/ezc-Authentication-1.1
	>=dev-php5/ezc-Database-1.3"
