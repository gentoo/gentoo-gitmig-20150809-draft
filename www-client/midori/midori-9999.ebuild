# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/midori/midori-9999.ebuild,v 1.11 2009/08/22 16:18:22 darkside Exp $

inherit git eutils multilib

DESCRIPTION="A lightweight web browser"
HOMEPAGE="http://www.twotoasts.de/index.php?/pages/midori_summary.html"
EGIT_REPO_URI="git://git.xfce.org/apps/midori"
EGIT_PROJECT="midori"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="net-libs/webkit-gtk
	net-libs/libsoup
	dev-db/sqlite"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	ewarn "Note: this software is not yet in a too mature status so expect some minor things to break"
}

src_compile() {
	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" ./waf --prefix="/usr/" --libdir="/usr/$(get_libdir)/" configure || die "waf configure failed."
	./waf build || die "waf build failed."
}

src_install() {
	DESTDIR=${D} ./waf install || die "waf install failed."
	dodoc AUTHORS ChangeLog INSTALL TODO
}
