# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/vanessa-logger/vanessa-logger-0.0.6.ebuild,v 1.3 2004/09/04 22:56:06 dholm Exp $

DESCRIPTION="Generic logging layer that may be used to log to one or more of syslog, an open file handle or a file name."
HOMEPAGE="http://www.vergenet.net/linux/vanessa/"
SRC_URI="http://www.vergenet.net/linux/vanessa/download/vanessa_logger/0.0.6/vanessa_logger-0.0.6.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ia64 ~ppc"
IUSE=""

DEPEND="virtual/libc"

S="${WORKDIR}/vanessa_logger-0.0.6"

src_install() {
	einstall
	dodoc AUTHORS NEWS README TODO sample/*.c sample/*.h
}
