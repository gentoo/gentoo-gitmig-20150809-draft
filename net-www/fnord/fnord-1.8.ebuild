# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/fnord/fnord-1.8.ebuild,v 1.1 2003/07/08 21:16:18 mholzer Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Yet another small httpd."
SRC_URI="http://www.fefe.de/fnord/${P}.tar.bz2
	mirror://gentoo/${P}-gentoo.diff"
HOMEPAGE="http://www.fefe.de/fnord/"

KEYWORDS="~x86 ~sparc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="dev-libs/dietlibc"
RDEPEND="sys-apps/daemontools"

pkg_setup() {

	if ! grep -q ^fnord: /etc/passwd ; then
	    useradd  -g nofiles -s /bin/false -d /etc/fnord -c "fnord" fnord\
			|| die "problem adding user fnord"
	fi
	if ! grep -q ^fnordlog: /etc/passwd ; then
	    useradd  -g nofiles -s /bin/false -d /etc/fnord -c "fnordlog" fnordlog\
			|| die "problem adding user fnordlog"
	fi
}

src_unpack() {
	unpack ${A} ; cd ${S}
	sed -i "s:^CFLAGS=-O.*:CFLAGS=${CFLAGS}:" Makefile

	patch -p0 < ${DISTDIR}/${PF}-gentoo.diff
}

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/bin
	doexe fnord-conf fnord

	dodoc TODO README SPEED COPYING CHANGES
}
