# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gamix/gamix-1.99_p14-r1.ebuild,v 1.3 2004/02/17 19:06:35 ciaranm Exp $

IUSE="nls gtk2"

PV=${P/_p/.p}
S=${WORKDIR}/${PV}
DESCRIPTION="GTK ALSA audio mixer"
HOMEPAGE="http://www1.tcnet.ne.jp/fmurata/linux/down"
SRC_URI="http://www1.tcnet.ne.jp/fmurata/linux/down/${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc -sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64"

DEPEND="virtual/alsa
	gtk2? ( >=x11-libs/gtk+-2.2.1 ) : ( =x11-libs/gtk+-1.2* )"

src_compile() {
	local myconf
	use gtk2 && myconf="--with-gtk-target=-2.0"
	econf `use_enable nls` ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
	dodoc README README.euc TODO NEWS INSTALL AUTHORS ABOUT-NLS COPYING
}
