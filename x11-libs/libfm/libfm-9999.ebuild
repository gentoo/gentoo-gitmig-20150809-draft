# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libfm/libfm-9999.ebuild,v 1.1 2010/06/22 14:27:31 hwoarang Exp $

EAPI="2"

inherit autotools eutils git

DESCRIPTION="Library for file management"
HOMEPAGE="http://pcmanfm.sourceforge.net/"
EGIT_REPO_URI="git://pcmanfm.git.sourceforge.net/gitroot/pcmanfm/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug demo"

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	>=lxde-base/menu-cache-0.3.2"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	eautoreconf
	einfo "Running intltoolize ..."
	intltoolize --force --copy --automake || die
	strip-linguas -i "${S}/po"
}

src_configure() {
	econf --sysconfdir=/etc $(use_enable debug) $(use_enable demo)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS TODO || die
}
