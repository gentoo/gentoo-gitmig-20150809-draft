# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/swfdec-mozilla/swfdec-mozilla-0.5.2.ebuild,v 1.1 2007/09/03 09:26:59 pclouds Exp $

inherit multilib versionator

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="Swfdec-mozilla is a decoder/renderer netscape style plugin for Macromedia Flash animations."
HOMEPAGE="http://swfdec.freedesktop.org/"
SRC_URI="http://swfdec.freedesktop.org/download/${PN}/${MY_PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="xulrunner"

DEPEND=">=media-libs/swfdec-0.5.1
	xulrunner? ( net-libs/xulrunner )
	!xulrunner? ( || ( www-client/mozilla-firefox www-client/seamonkey ) )"
RDEPEND=""

src_install() {
		  exeinto /usr/$(get_libdir)/nsbrowser/plugins
		  doexe src/.libs/libswfdecmozilla.so || die "libswfdecmozilla.so failed"
		  insinto /usr/$(get_libdir)/nsbrowser/plugins
		  doins src/libswfdecmozilla.la
}
