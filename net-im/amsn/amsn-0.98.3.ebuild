# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/amsn/amsn-0.98.3.ebuild,v 1.7 2011/02/26 19:38:07 signals Exp $

EAPI=2

inherit eutils fdo-mime gnome2-utils

MY_P=${P/_rc/RC}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Alvaro's Messenger client for MSN"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${MY_P}-src.tar.bz2"
HOMEPAGE="http://www.amsn-project.net"

# The tests are interactive
RESTRICT="test"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ppc -sparc x86"
IUSE="debug"

DEPEND=">=dev-lang/tcl-8.4
	>=dev-lang/tk-8.4
	virtual/jpeg
	media-libs/libpng
	>=dev-tcltk/snack-2.2.10
	>=net-libs/gupnp-igd-0.1.3
	media-libs/libv4l"
#	>=net-libs/farsight2-0.0.14
#	>=media-libs/gstreamer-0.10.23
#	>=media-libs/gst-plugins-base-0.10.23

RDEPEND="${DEPEND}
	>=dev-tcltk/tls-1.5
	media-video/ffmpeg[encode]"
#	>=media-libs/gst-plugins-good-0.10.15
#	>=media-libs/gst-plugins-bad-0.10.13
#	>=media-plugins/gst-plugins-ffmpeg-0.10.7

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.98-noautoupdate.patch"
	# only portage should strip files, bug 285682
	sed -i -e "s/LDFLAGS += -s/LDFLAGS += /" Makefile.in || die "sed failed"
}

src_configure() {
	econf $(use_enable debug) || die "configure script failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AGREEMENT TODO README FAQ CREDITS

	domenu amsn.desktop
	sed -i -e s:.png:: "${D}/usr/share/applications/amsn.desktop"

	cd desktop-icons
	for i in *; do
		if [ -e ${i}/msn.png ]; then
			insinto /usr/share/icons/hicolor/${i}/apps
			doins  ${i}/msn.png
		fi
	done
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update

	ewarn "You might have to remove ~/.amsn prior to running as user if amsn hangs on start-up."
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
