# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/libpst/libpst-0.4.1.ebuild,v 1.1 2004/12/04 10:59:48 ka0ttic Exp $

inherit eutils

MY_P="${P/-/_}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Tools and library for reading Outlook files (.pst format)"
# note: HOMEPAGE is outdated ; current upstream page is unknown
HOMEPAGE="http://sourceforge.net/projects/ol2mbox"
SRC_URI="mirror://gentoo/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README AUTHORS CREDITS TODO FILE-FORMAT || die "dodoc failed"
	dohtml FILE-FORMAT.html || die "dohtml failed"
}
