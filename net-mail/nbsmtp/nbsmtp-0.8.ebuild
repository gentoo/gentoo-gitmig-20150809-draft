# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Scott Moynes <smoynes@nexus.carleton.ca>
# $Header: /var/cvsroot/gentoo-x86/net-mail/nbsmtp/nbsmtp-0.8.ebuild,v 1.1 2002/02/22 02:58:29 g2boojum Exp $

S=${WORKDIR}

DESCRIPTION="The No-Brainer SMTP"

SRC_URI="http://physeeks.dyndns.org:8000/download/${P}.tgz"

HOMEPAGE="http://physeeks.dyndns.org:8000/software.html"

DEPEND="virtual/glibc"

PROVIDE="virtual/mta"

src_compile() {
	gcc ${CFLAGS} -o nbsmtp nbsmtp.c || die
}

src_install () {
	dobin nbsmtp
	dodoc COPYING
}
