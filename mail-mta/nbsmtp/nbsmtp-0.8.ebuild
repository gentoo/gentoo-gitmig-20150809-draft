# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/nbsmtp/nbsmtp-0.8.ebuild,v 1.4 2004/07/14 16:51:10 agriffis Exp $

S=${WORKDIR}
DESCRIPTION="The No-Brainer SMTP"
SRC_URI="http://physeeks.dyndns.org:8000/download/${P}.tgz"
HOMEPAGE="http://physeeks.dyndns.org:8000/software.html"

DEPEND="virtual/libc"
PROVIDE="virtual/mta"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""

src_compile() {
	gcc ${CFLAGS} -o nbsmtp nbsmtp.c || die
}

src_install () {
	dobin nbsmtp
	dodoc COPYING
}
