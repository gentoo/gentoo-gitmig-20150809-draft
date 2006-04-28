# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins-base/gst-plugins-base-0.10.6.ebuild,v 1.1 2006/04/28 11:14:15 zaheerm Exp $

# order is important, gnome2 after gst-plugins
inherit gst-plugins-base gst-plugins10 gnome2 eutils flag-o-matic libtool

DESCRIPTION="Basepack of plugins for gstreamer"
HOMEPAGE="http://gstreamer.net/"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa esd oss X xv"

RDEPEND=">=dev-libs/glib-2.6
	 >=media-libs/gstreamer-0.10.5
	 >=dev-libs/liboil-0.3.6"

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.11.5
	>=dev-util/pkgconfig-0.9"

PDEPEND="oss? ( >=media-plugins/gst-plugins-oss-0.10 )
	alsa? ( >=media-plugins/gst-plugins-alsa-0.10 )
	esd? ( >=media-plugins/gst-plugins-esd-0.10 )
	X? ( >=media-plugins/gst-plugins-x-0.10 )
	xv? ( >=media-plugins/gst-plugins-xvideo-0.10 )"

src_compile() {

	elibtoolize

	# gst doesnt handle optimisations well
	strip-flags
	replace-flags "-O3" "-O2"
	filter-flags "-fprefetch-loop-arrays" # see bug 22249
	if use alpha || use amd64 || use ia64 || use hppa; then
		append-flags -fPIC
	fi

	gst-plugins-base_src_configure

	emake || die

}

# override eclass
src_install() {

	gnome2_src_install

}

DOCS="AUTHORS INSTALL README RELEASE TODO"
