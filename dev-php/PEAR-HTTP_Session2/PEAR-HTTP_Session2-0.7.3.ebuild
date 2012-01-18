# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-HTTP_Session2/PEAR-HTTP_Session2-0.7.3.ebuild,v 1.1 2012/01/18 19:49:05 mabi Exp $

inherit php-pear-r1

DESCRIPTION="Wraps PHP's session_* functions. Provides extras such as database storage for session data using DB package."

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="${DEPEND}
	!minimal? ( >=dev-php/PEAR-MDB2-2.4.1
			>=dev-php/PEAR-DB-1.7.11 )"
