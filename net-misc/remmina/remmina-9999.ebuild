# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/remmina/remmina-9999.ebuild,v 1.3 2011/11/23 20:57:50 hwoarang Exp $

EAPI=2
EGIT_REPO_URI="git://github.com/FreeRDP/Remmina.git"
EGIT_PROJECT="remmina"
EGIT_SOURCEDIR="${WORKDIR}"

inherit autotools git-2 eutils gnome2-utils

DESCRIPTION="A GTK+ RDP, VNC, XDMCP and SSH client"
HOMEPAGE="http://remmina.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="avahi crypt debug nls ssh unique vte"

RDEPEND="x11-libs/gtk+:2
	avahi? ( net-dns/avahi )
	crypt? ( dev-libs/libgcrypt )
	nls? ( virtual/libintl )
	ssh? ( net-libs/libssh[sftp] )
	unique? ( dev-libs/libunique:1 )
	vte? ( x11-libs/vte:0 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${PN}"

src_prepare() {
	intltoolize --force --copy --automake
	eautoreconf
}

src_configure() {
	if use ssh && ! use vte; then
		ewarn "Enabling ssh without vte only provides sftp support."
	fi

	econf \
		--disable-dependency-tracking \
		$(use_enable avahi) \
		$(use_enable crypt gcrypt) \
		$(use_enable debug) \
		$(use_enable nls) \
		$(use_enable ssh) \
		$(use_enable unique) \
		$(use_enable vte)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	elog "You need to install net-misc/remmina-plugins which"
	elog "provide all the necessary network protocols required by ${PN}"
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
