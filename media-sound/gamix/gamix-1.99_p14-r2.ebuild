# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gamix/gamix-1.99_p14-r2.ebuild,v 1.10 2008/04/14 12:50:40 drac Exp $

MY_P=${P/_p/.p}

DESCRIPTION="GTK ALSA audio mixer"
HOMEPAGE="http://www1.tcnet.ne.jp/fmurata/linux/down"
SRC_URI="http://www1.tcnet.ne.jp/fmurata/linux/down/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 -sparc x86"
IUSE="nls"

RDEPEND="media-libs/alsa-lib
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf $(use_enable nls) --with-gtk-target=-2.0
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS NEWS README README.euc TODO
}
