# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gtkguitune/gtkguitune-0.8.ebuild,v 1.1 2009/05/02 15:05:33 ssuominen Exp $

EAPI=2
inherit eutils gnome2-utils

DESCRIPTION="A guitar tuning program that uses Schmitt-triggering for quick feedback"
HOMEPAGE="http://www.geocities.com/harpin_floh/kguitune_page.html"
SRC_URI="http://www.geocities.com/harpin_floh/mysoft/${PN}-gtk2-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-cpp/glibmm:2
	dev-cpp/gtkmm:2.4
	dev-libs/libsigc++:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	make_desktop_entry ${PN} Guitune guitune_logo
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
