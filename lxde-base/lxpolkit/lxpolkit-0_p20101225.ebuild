# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxpolkit/lxpolkit-0_p20101225.ebuild,v 1.2 2011/01/24 17:56:58 ssuominen Exp $

EAPI=3
inherit autotools

DESCRIPTION="A simple PolicyKit authentication agent"
HOMEPAGE="http://blog.lxde.org/?p=674"
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.18:2
	>=lxde-base/menu-cache-0.3.2
	>=sys-auth/polkit-0.99
	>=x11-libs/gtk+-2.12:2
	!gnome-extra/polkit-gnome"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	>=dev-util/intltool-0.40.0
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	# NotShowIn=KDE; because they have polkit-kde, but this
	# is exchangeable with polkit-gnome. The blocker is valid,
	# and it's other packages that need || ( ) deps.
	sed -i -e '/ShowIn/d' data/lxpolkit.desktop.in.in || die
	echo 'NotShowIn=KDE;' >> data/lxpolkit.desktop.in.in

	intltoolize --force --copy --automake
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS
}
