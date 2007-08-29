# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins-bad/gst-plugins-bad-0.10.5.ebuild,v 1.2 2007/08/29 18:09:24 drac Exp $

inherit gst-plugins-bad gnome2 eutils flag-o-matic libtool

DESCRIPTION="Unmaintained plugins for GStreamer"
HOMEPAGE="http://gstreamer.freedesktop.org/"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"

RDEPEND=">=media-libs/gst-plugins-base-0.10.13
	>=media-libs/gstreamer-0.10.13"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
}

src_compile() {
	elibtoolize

	strip-flags
	replace-flags "-O3" "-O2"
	filter-flags "-fprefetch-loop-arrays" # (Bug #22249)

	if use alpha || use amd64 || use ia64 || use hppa ; then
		append-flags -fPIC
	fi

	gst-plugins-bad_src_configure

	emake || die
}

src_install() {
	gnome2_src_install
}

DOCS="AUTHORS ChangeLog NEWS README RELEASE"

pkg_postinst() {
	gnome2_pkg_postinst
}

pkg_postrm() {
	gnome2_pkg_postrm
}
