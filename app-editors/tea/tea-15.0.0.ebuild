# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/tea/tea-15.0.0.ebuild,v 1.1 2006/12/30 22:18:15 welp Exp $

inherit eutils

DESCRIPTION="Small, lightweight GTK+ text editor"
HOMEPAGE="http://tea-editor.sourceforge.net/"
SRC_URI="mirror://sourceforge/tea-editor/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 gnome spell"

RDEPEND="x11-libs/gtk+
	gnome? ( x11-libs/gtksourceview
		gnome-base/gnome-vfs )"
DEPEND="${RDEPEND}
	x11-libs/libX11
	spell? ( app-text/aspell )
	dev-util/pkgconfig"

src_compile() {
	econf \
	$(use_enable ipv6 ) \
	$(use_enable !gnome legacy ) \
	|| die "Configure failed!"

	emake || die "Make failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "Make Install failed!"

	doicon ${FILESDIR}/tea_icon_v2.png
	make_desktop_entry tea Tea tea_icon_v2.png Office
}

pkg_postinst() {
	if use spell ; then
		elog "To get full spellchecking functuality, ensure that you install"
		elog "the relevant language pack"
	fi
}
