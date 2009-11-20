# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pcmanfm/pcmanfm-0.5.2.ebuild,v 1.3 2009/11/20 14:26:35 maekke Exp $

EAPI="2"
inherit autotools eutils fdo-mime

DESCRIPTION="Extremely fast and lightweight tabbed file manager"
HOMEPAGE="http://pcmanfm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="hal"

RDEPEND="virtual/fam
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-misc/shared-mime-info
	x11-themes/gnome-icon-theme
	x11-libs/startup-notification
	hal? ( sys-apps/hal )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	# Don't break Gnome & possibly other environments, bug 272318
	epatch "${FILESDIR}"/pcmanfm-find.desktop.patch
	#Fixing ca translation, bug #290983
	epatch "${FILESDIR}"/${P}-fix-ca-translation.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable hal)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	if has_version app-admin/fam ; then
		elog "You are using fam as your file alteration monitor,"
		elog "so you must have famd started before running pcmanfm."
		elog
		elog "To add famd to the default runlevel and start it, run:"
		elog
		elog "# rc-update add famd default"
		elog "# /etc/init.d/famd start"
		elog
		elog "It is recommended you use gamin instead of fam."
	fi
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
