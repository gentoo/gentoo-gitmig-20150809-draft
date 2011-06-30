# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gstreamer/gstreamer-0.10.35.ebuild,v 1.1 2011/06/30 11:16:43 leio Exp $

EAPI=2

inherit eutils multilib versionator

# Create a major/minor combo for our SLOT and executables suffix
PV_MAJ_MIN=$(get_version_component_range '1-2')

DESCRIPTION="Streaming media framework"
HOMEPAGE="http://gstreamer.sourceforge.net"
SRC_URI="http://${PN}.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT=${PV_MAJ_MIN}
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="+introspection nls test"

RDEPEND=">=dev-libs/glib-2.22:2
	dev-libs/libxml2
	introspection? ( >=dev-libs/gobject-introspection-0.6.3 )
	!<media-libs/gst-plugins-base-0.10.26"
	# ^^ queue2 move, mustn't have both libgstcoreleements.so and libgstqueue2.so at runtime providing the element at once
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"
	# dev-util/gtk-doc-am # Only if eautoreconf'ing

src_configure() {
	# Disable static archives, dependency tracking and examples
	# to speed up build time
	# Disable debug, as it only affects -g passing (debugging symbols), this must done through make.conf in gentoo
	econf \
		--disable-static \
		--disable-dependency-tracking \
		$(use_enable nls) \
		--disable-valgrind \
		--disable-examples \
		--disable-debug \
		--enable-check \
		$(use_enable introspection) \
		$(use_enable test tests) \
		--with-package-name="GStreamer ebuild for Gentoo" \
		--with-package-origin="http://packages.gentoo.org/package/media-libs/gstreamer"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS MAINTAINERS README RELEASE

	# Remove unversioned binaries to allow SLOT installations in future
	cd "${D}"/usr/bin
	local gst_bins
	for gst_bins in $(ls *-${PV_MAJ_MIN}); do
		rm -f ${gst_bins/-${PV_MAJ_MIN}/}
	done
}
