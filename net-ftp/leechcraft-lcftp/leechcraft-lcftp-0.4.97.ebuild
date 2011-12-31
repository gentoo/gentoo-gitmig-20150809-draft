# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/leechcraft-lcftp/leechcraft-lcftp-0.4.97.ebuild,v 1.1 2011/12/31 12:08:18 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LCFTP, FTP client for LeechCraft."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
		>=net-misc/curl-7.19.4"
RDEPEND="${DEPEND}
		virtual/leechcraft-task-show"
