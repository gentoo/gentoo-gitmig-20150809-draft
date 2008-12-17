# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcanberra/libcanberra-0.9.ebuild,v 1.3 2008/12/17 15:22:55 ranger Exp $

EAPI="1"

DESCRIPTION="Portable Sound Event Library"
HOMEPAGE="http://0pointer.de/lennart/projects/libcanberra/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE="alsa doc gstreamer gtk pulseaudio"

RDEPEND="media-libs/libvorbis
	sys-devel/libtool
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.11 )
	gstreamer? ( >=media-libs/gstreamer-0.10.15 )
	gtk? ( dev-libs/glib:2
		>=x11-libs/gtk+-2.13.4:2 )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.17
	doc? ( >=dev-util/gtk-doc-1.9 )"

src_compile() {
	econf --disable-static \
		$(use_enable alsa) \
		$(use_enable gtk) \
		$(use_enable pulseaudio pulse) \
		$(use_enable gstreamer) \
		$(use_enable doc gtk-doc) \
		--disable-oss \
		--disable-tdb \
		--disable-lynx
	# tdb support would need a split-out from samba before we can use it

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	rm "${D}/usr/share/doc/${PN}/README"
	# If the rmdir errors, you probably need to add a file to dodoc
	# and remove the package installed above
	rmdir "${D}/usr/share/doc/${PN}"
	dodoc README
}
