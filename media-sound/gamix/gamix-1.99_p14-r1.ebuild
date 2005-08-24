# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gamix/gamix-1.99_p14-r1.ebuild,v 1.14 2005/08/24 18:20:42 agriffis Exp $

MY_P=${P/_p/.p}
S=${WORKDIR}/${MY_P}
DESCRIPTION="GTK ALSA audio mixer"
HOMEPAGE="http://www1.tcnet.ne.jp/fmurata/linux/down"
SRC_URI="http://www1.tcnet.ne.jp/fmurata/linux/down/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ia64 ~ppc ppc64 -sparc x86"
IUSE="nls gtk2"

DEPEND="virtual/alsa
	gtk2? ( >=x11-libs/gtk+-2.2.1 )
	!gtk2? ( =x11-libs/gtk+-1.2* )"

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
