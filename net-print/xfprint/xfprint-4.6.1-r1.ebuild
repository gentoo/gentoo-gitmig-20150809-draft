# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/xfprint/xfprint-4.6.1-r1.ebuild,v 1.10 2010/08/11 20:52:05 josejx Exp $

EAPI=3
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="A graphical frontend for printing, a printer management, and a job queue management"
HOMEPAGE="http://www.xfce.org/projects/xfprint/"
SRC_URI="mirror://xfce/src/archive/${PN}/4.6/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="cups debug"

RDEPEND="app-text/a2ps
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/xfconf-4.6
	cups? ( net-print/cups )
	!cups? ( net-print/lprng )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-xfconf_channel_fix.diff )
	XFCONF="--disable-dependency-tracking
		--disable-static
		--enable-bsdlpr
		$(use_enable cups)
		$(xfconf_use_debug)
		--with-html-dir=${EPREFIX}/usr/share/doc/${PF}/html"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	sed -i -e '/24x24/d' icons/Makefile.am || die
	xfconf_src_prepare
}
