# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/e16keyedit/e16keyedit-0.2.ebuild,v 1.19 2004/07/04 19:09:13 slarti Exp $

inherit eutils

DESCRIPTION="Key binding editor for enlightenment 16"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/e16utils/${P}.tar.gz"
IUSE=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64"

DEPEND="virtual/x11
	>=x11-wm/enlightenment-0.16
	=x11-libs/gtk+-1*
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:-lgdbm -lgdk_imlib::' Makefile
	epatch ${FILESDIR}/${PV}-fullscreen.patch
}

src_compile() {
	emake EXTRA_CFLAGS="${CFLAGS}" || die
}

src_install() {
	 dobin e16keyedit
	 dodoc README COPYING ChangeLog AUTHORS
}
