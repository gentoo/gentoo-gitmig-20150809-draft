# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/xfprint/xfprint-4.4.2-r1.ebuild,v 1.1 2008/06/22 22:55:02 drac Exp $

inherit eutils

DESCRIPTION="GTK+ and Xfce4 frontend for printing, management and job queue."
HOMEPAGE="http://www.xfce.org/projects/xfprint"
SRC_URI="mirror://xfce/xfce-${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="cups debug doc"

RDEPEND="cups? ( net-print/cups )
	!cups? ( net-print/lprng )
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4mcs-4.4
	>=xfce-base/libxfce4util-4.4
	>=xfce-base/libxfcegui4-4.4
	>=xfce-base/xfce-mcs-manager-4.4
	app-text/a2ps"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"
#	doc? ( dev-util/gtk-doc )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	EPATCH_SUFFIX="patch" epatch "${FILESDIR}"/${PV}
}

src_compile() {
	local myconf="--enable-bsdlpr"
	use cups && myconf="--enable-cups"

	econf --disable-dependency-tracking \
		$(use_enable debug) \
		$(use_enable doc gtk-doc) \
		${myconf}

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
