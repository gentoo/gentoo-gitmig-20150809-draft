# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmix/wmix-3.1-r1.ebuild,v 1.4 2006/08/18 02:03:42 malc Exp $

inherit eutils

IUSE=""
DESCRIPTION="Dockapp mixer for OSS or ALSA"
SRC_URI="http://www.ne.jp/asahi/linux/timecop/software/${P}.tar.gz"
HOMEPAGE="http://www.ne.jp/asahi/linux/timecop/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc ~sparc x86"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )
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
