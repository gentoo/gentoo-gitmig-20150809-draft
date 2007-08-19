# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gtick/gtick-0.4.1.ebuild,v 1.1 2007/08/19 15:04:23 drac Exp $

inherit eutils

DESCRIPTION="a metronome application supporting different meters and speeds ranging"
HOMEPAGE="http://www.antcom.de/gtick"
SRC_URI="http://www.antcom.de/gtick/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="nls sndfile"

RDEPEND=">=x11-libs/gtk+-2
	sndfile? ( media-libs/libsndfile )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:-O3::" configure
}

src_compile() {
	econf $(use_enable nls) \
		$(use_with sndfile)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	newicon src/icon32x32.xpm gtick.xpm
	make_desktop_entry ${PN} "GTick" ${PN}.xpm
}
