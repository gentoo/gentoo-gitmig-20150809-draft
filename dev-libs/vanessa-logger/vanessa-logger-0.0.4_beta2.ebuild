# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/vanessa-logger/vanessa-logger-0.0.4_beta2.ebuild,v 1.9 2004/08/03 11:48:32 dholm Exp $

DESCRIPTION="Generic logging layer that may be used to log to one or more of syslog, an open file handle or a file name."
HOMEPAGE="http://www.vergenet.net/linux/vanessa/"
SRC_URI="http://www.vergenet.net/linux/perdition/download/BETA/1.11beta5/vanessa_logger-0.0.4beta2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha ia64 ~ppc"

IUSE=""
DEPEND="virtual/libc"
S=${WORKDIR}/vanessa_logger-0.0.4beta2

src_compile() {
	econf || die "econf failed"

	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS COPYING NEWS README TODO
}
