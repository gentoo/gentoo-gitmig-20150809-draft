# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot/jpilot-1.8.0.ebuild,v 1.1 2010/07/13 13:29:07 ssuominen Exp $

EAPI=2

DESCRIPTION="Desktop Organizer Software for the Palm Pilot"
HOMEPAGE="http://www.jpilot.org/"
SRC_URI="http://www.jpilot.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="nls"

RDEPEND=">=app-pda/pilot-link-0.12.5
	dev-libs/libgcrypt
	>=x11-libs/gtk+-2.18.9:2"
DEPEND="${RDEPEND}
	nls? ( dev-util/intltool
		sys-devel/gettext )
	dev-util/pkgconfig"

src_prepare() {
	sed -i \
		-e "/^Icon/s:jpilot.xpm:/usr/share/pixmaps/jpilot/jpilot-icon1.xpm:" \
		jpilot.desktop || die
}

src_configure() {
	econf \
		$(use_enable nls)
}

src_install() {
	emake \
		DESTDIR="${D}" \
		icondir="/usr/share/pixmaps/${PN}" \
		miscdir="/usr/share/doc/${PF}" \
		install || die

	rm -f "${D}"/usr/share/doc/${PF}/{COPYING,INSTALL} \
		"${D}"/usr/share/pixmaps/${PN}/README

	find "${D}" -name '*.la' -delete
}
