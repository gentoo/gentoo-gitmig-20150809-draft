# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/fsviewer/fsviewer-0.2.6.ebuild,v 1.1 2010/06/26 23:42:32 ssuominen Exp $

EAPI=2
inherit multilib

MY_P=${PN}-app-${PV}

DESCRIPTION="A file system viewer for Window Maker"
HOMEPAGE="http://www.bayernline.de/~gscholz/linux/fsviewer/"
SRC_URI="http://www.bayernline.de/~gscholz/linux/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND="x11-wm/windowmaker
	x11-libs/libXft
	x11-libs/libXpm
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		--with-appspath=/usr/$(get_libdir)/GNUstep
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
