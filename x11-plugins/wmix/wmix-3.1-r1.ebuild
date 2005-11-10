# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmix/wmix-3.1-r1.ebuild,v 1.2 2005/11/10 09:39:32 s4t4n Exp $

inherit eutils

IUSE=""
DESCRIPTION="Dockapp mixer for OSS or ALSA"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/software/${P}.tar.gz"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~amd64 ~ppc"

DEPEND="virtual/x11
	>=sys-apps/sed-4"

src_unpack()
{
	unpack ${A} ; cd ${S}
	sed -i -e "/^CFLAGS/d" Makefile

	# duh, wmix author forgot to update the version number
	epatch ${FILESDIR}/fix-wmix-3.1-version-number.patch
}

src_compile()
{
	emake || die
}

src_install ()
{
	exeinto /usr/bin
	doexe wmix

	# Original manpage does not work, we provide a fixed (and updated) one
	doman ${FILESDIR}/wmix.1

	dodoc README NEWS BUGS AUTHORS sample.wmixrc
}
