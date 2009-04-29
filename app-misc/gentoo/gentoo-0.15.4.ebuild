# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gentoo/gentoo-0.15.4.ebuild,v 1.1 2009/04/29 23:11:01 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="A modern GTK+ based filemanager for any WM"
HOMEPAGE="http://www.obsession.se/gentoo/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="fam nls"

RDEPEND=">=x11-libs/gtk+-2.2:2
	>=dev-libs/glib-2.14:2
	fam? ( virtual/fam )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--sysconfdir=/etc/gentoo \
		$(use_enable nls) \
		$(use_enable fam)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS BUGS ChangeLog CONFIG-CHANGES CREDITS NEWS \
		README TODO docs/{FAQ,menus.txt}

	dohtml -r docs/{images,config,*.{html,css}}

	newman docs/gentoo.1x gentoo.1

	docinto scratch
	dodoc docs/scratch/*

	make_desktop_entry ${PN} Gentoo \
		/usr/share/${PN}/icons/${PN}.png \
		"System;FileTools;FileManager"
}
