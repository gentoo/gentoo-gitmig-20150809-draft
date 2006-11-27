# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/asapm/asapm-2.10.ebuild,v 1.10 2006/11/27 13:14:08 gustavoz Exp $

inherit eutils

DESCRIPTION="APM monitor for AfterStep"
SRC_URI="http://www.tigr.net/afterstep/download/asapm/asapm-2.10.tar.gz"

HOMEPAGE="http://www.tigr.net/afterstep/list.pl"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="-sparc x86"

DEPEND="virtual/libc virtual/x11"

src_compile() {
	./configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST} || die
	epatch ${FILESDIR}/${PF}-gentoo.diff
	emake || die
}

src_install () {
	dodir usr/bin
	dodir usr/share/man/man1

	make prefix=${D} install || die
}

