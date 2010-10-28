# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.7.0.ebuild,v 1.8 2010/10/28 16:38:06 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Collection of utils for Xfce4"
HOMEPAGE="http://www.xfce.org/projects/xfce-utils/"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.7/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="dbus debug +lock"

# XML-Parser is really a runtime dependency for xfconf-migration-4.6.pl script
RDEPEND="dev-perl/XML-Parser
	x11-apps/xrdb
	x11-libs/libX11
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfce4ui-4.7
	>=xfce-base/xfconf-4.6
	dbus? ( >=dev-libs/dbus-glib-0.70 )
	lock? ( || ( x11-misc/xscreensaver
		gnome-extra/gnome-screensaver
		x11-misc/xlockmore
		x11-misc/slock ) )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-ck-launch-session.patch )
	XFCONF="--docdir=${EPREFIX}/usr/share/doc/${PF}
		--disable-dependency-tracking
		$(use_enable dbus)
		$(xfconf_use_debug)
		--with-vendor-info=Gentoo
		--with-xsession-prefix=${EPREFIX}/usr"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_install() {
	xfconf_src_install

	# Help is outdated and we install HTML files to $PF
	rm -f "${ED}"/usr/share/applications/xfhelp4.desktop

	insinto /usr/share/xfce4
	doins "${FILESDIR}"/Gentoo || die

	echo startxfce4 > "${T}"/Xfce4
	exeinto /etc/X11/Sessions
	doexe "${T}"/Xfce4 || die
}
