# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/imhangul/imhangul-0.9.15.ebuild,v 1.2 2011/03/27 10:49:19 nirbheek Exp $

EAPI="1"

inherit multilib

DESCRIPTION="Gtk+-2.0 Hangul Input Modules"
HOMEPAGE="http://kldp.net/projects/imhangul/"
SRC_URI="http://kldp.net/frs/download.php/5418/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=app-i18n/libhangul-0.0.10
	>=x11-libs/gtk+-2.2.0:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

get_gtk_confdir() {
	if has_multilib_profile ; then
		GTK2_CONFDIR="${GTK2_CONFDIR:=/etc/gtk-2.0/${CHOST}}"
	else
		GTK2_CONFDIR="${GTK2_CONFDIR:=/etc/gtk-2.0}"
	fi
	echo ${GTK2_CONFDIR}
}

src_compile() {
	econf \
		--with-gtk-im-module-dir=/usr/$(get_libdir)/gtk-2.0/immodules \
		--with-gtk-im-module-file=$(get_gtk_confdir) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	gtk-query-immodules-2.0 > "${ROOT}$(get_gtk_confdir)/gtk.immodules"

	elog ""
	elog "If you want to use one of the module as a default input method, "
	elog ""
	elog "export GTK_IM_MODULE=hangul2  # 2 input type"
	elog "export GTK_IM_MODULE=hangul3f # 3 input type"
	elog ""
}

pkg_postrm() {
	gtk-query-immodules-2.0 > "${ROOT}$(get_gtk_confdir)/gtk.immodules"
}
