# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/nbsmtp/nbsmtp-0.8.ebuild,v 1.9 2004/02/22 16:22:19 agriffis Exp $

S=${WORKDIR}
DESCRIPTION="The No-Brainer SMTP"
SRC_URI="http://physeeks.dyndns.org:8000/download/${P}.tgz"
HOMEPAGE="http://physeeks.dyndns.org:8000/software.html"

DEPEND="virtual/glibc"
PROVIDE="virtual/mta"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

src_compile() {
	gcc ${CFLAGS} -o nbsmtp nbsmtp.c || die
}

src_install () {
	dobin nbsmtp
	dodoc COPYING
}
