# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/snarf/snarf-7.0-r2.ebuild,v 1.9 2004/03/26 01:11:39 weeve Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="A full featured small web-spider"
SRC_URI="http://www.xach.com/snarf/${P}.tar.gz"
HOMEPAGE="http://www.xach.com/snarf/"
KEYWORDS="x86 alpha sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/snarf-basename-patch.diff
	epatch ${FILESDIR}/snarf-unlink-empty.diff
}

src_install() {
	dobin snarf
	doman snarf.1
	dodoc COPYING ChangeLog README TODO
}

pkg_postinst() {
	einfo 'To use snarf with portage, try these settings in your make.conf'
	einfo
	einfo '	FETCHCOMMAND="/usr/bin/snarf -b \${URI} \${DISTDIR}/\${FILE}"'
	einfo '	RESUMECOMMAND="/usr/bin/snarf -rb \${URI} \${DISTDIR}/\${FILE}"'
}
