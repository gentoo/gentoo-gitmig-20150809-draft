# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libfm/libfm-9999.ebuild,v 1.5 2010/10/17 12:00:33 hwoarang Exp $

EAPI="2"

inherit autotools eutils git

DESCRIPTION="Library for file management"
HOMEPAGE="http://pcmanfm.sourceforge.net/"
EGIT_REPO_URI="git://pcmanfm.git.sourceforge.net/gitroot/pcmanfm/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug demo gnome hal udev"

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	udev? ( sys-fs/udisks )
	gnome? ( hal? ( gnome-base/gnome-mount ) )
	gnome? ( gnome-base/gvfs[hal?,udev?] )
	>=lxde-base/menu-cache-0.3.2"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	dev-util/gtk-doc
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	for file in app-chooser.ui ask-rename.ui file-prop.ui preferred-apps.ui \
		progress.ui;do
			echo "data/ui/${file}" >> po/POTFILES.in
	done
	echo "src/udisks/g-udisks-device.c" >> po/POTFILES.in
	gtkdocize
	eautoreconf
	einfo "Running intltoolize ..."
	intltoolize --force --copy --automake || die
	strip-linguas -i "${S}/po"
}

src_configure() {
	econf --sysconfdir=/etc \
		$(use_enable debug) \
		$(use_enable demo) \
		$(use_enable udev udisks)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS TODO || die
}
