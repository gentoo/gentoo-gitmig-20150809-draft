# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pcmanfm/pcmanfm-0.9.9_pre20110614.ebuild,v 1.1 2011/06/14 09:15:05 hwoarang Exp $

EAPI=2

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="git://pcmanfm.git.sourceforge.net/gitroot/pcmanfm/${PN}"
	inherit autotools git
	SRC_URI=""
else
	inherit autotools
	SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~ppc ~x86"
fi

inherit fdo-mime

DESCRIPTION="Fast lightweight tabbed filemanager"
HOMEPAGE="http://pcmanfm.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

COMMON_DEPEND=">=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.22.1:2
	>=lxde-base/menu-cache-0.3.2
	>=x11-libs/libfm-0.1.15_pre20110202"
RDEPEND="${COMMON_DEPEND}
	virtual/eject"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	intltoolize --force --copy --automake || die
	# Fix tests. Bug #357125
	for x in about autorun desktop-pref pref; do
		echo  data/ui/${x}.ui >> po/POTFILES.in
	done
	# Fix desktop icons
	sed -i -e "/MimeType/s:=.*normal;:=:" data/${PN}.desktop.in \
		|| die "failed to fix desktop icon"
	eautoreconf
}

src_configure() {
	econf \
		--sysconfdir=/etc \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	elog 'PCmanFM can optionally support the menu://applications/ location.'
	elog 'You should install lxde-base/lxmenu-data for that	functionality.'
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
