# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gamix/gamix-1.99_p14.ebuild,v 1.1 2003/09/20 12:19:49 jje Exp $

PV=${P/_p/.p}
S=${WORKDIR}/${PV}
DESCRIPTION="GTK ALSA audio mixer"
SRC_URI="http://www1.tcnet.ne.jp/fmurata/linux/down/${PV}.tar.gz"
HOMEPAGE="http://www1.tcnet.ne.jp/fmurata/linux/down"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="nls gtk2"

DEPEND=">=media-sound/alsa-driver-0.9_rc1
	>=media-libs/alsa-lib-0.9_rc1
	x11-libs/gtk+
	dev-libs/glib
	gtk2? >=x11-libs/gtk+-2.2.1"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls ${myconf}"
	use gtk2 && myconf="--with-gtk-target=-2.0 ${myconf}"
	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc README README.euc TODO NEWS INSTALL AUTHORS ABOUT-NLS COPYING
}

