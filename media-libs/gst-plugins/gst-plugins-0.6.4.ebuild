# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins/gst-plugins-0.6.4.ebuild,v 1.11 2004/01/29 05:00:43 agriffis Exp $

# IMPORTANT
#
# Since gst-plugins uses a local copy of ffmpeg we consider this a non-external plugin
# In essence this means gst-plugins without any external plugins already provides a
# wide range of audio/video codecs
#
# This may change in the future, but for now 3rd-party apps do probably not need to depend
# on mpeg/avi plugins etcetera unless they are directly referenced

# order is important, gnome2 after gst-plugins
inherit gst-plugins gnome2 eutils flag-o-matic

DESCRIPTION="Basepack of plugins for gstreamer"
HOMEPAGE="http://gstreamer.net/"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc alpha hppa ~amd64 ia64"

RDEPEND="=media-libs/gstreamer-${PV}*
	>=gnome-base/gconf-1.2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

PDEPEND=">=media-plugins/gst-plugins-oss-${PV}"

BUILD_GST_PLUGINS="ffmpeg"

# needed for ffmpeg
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {

	unpack ${A}

	cd ${S}
	# ppc asm included in the resample plugin seems to be broken,
	# using a slower but working version for now
	epatch ${FILESDIR}/noppcasm.patch
	# Fix for building with gcc2 (#32192)
	epatch ${FILESDIR}/${P}-gcc2_fix.patch

	# fix the scripts
	cd ${S}/tools
	mv gst-launch-ext gst-launch-ext.old
	sed -e "s:gst-launch :gst-launch-${PV_MAJ_MIN} :" \
		-e "s:gst-launch-ext:gst-launch-ext-${PV_MAJ_MIN}:" gst-launch-ext.old > gst-launch-ext
	chmod +x gst-launch-ext

	mv gst-visualise gst-visualise.old
	sed -e "s:gst-launch :gst-launch-${PV_MAJ_MIN} :" \
		-e "s:gst-visualise:gst-visualise-${PV_MAJ_MIN}:" gst-visualise.old > gst-visualise
	chmod +x gst-visualise

}

src_compile() {

	elibtoolize

	# gst doesnt handle optimisations well
	strip-flags
	replace-flags "-O3" "-O2"
	filter-flags "-fprefetch-loop-arrays" # see bug 22249

	filter-flags "-fPIC" # for hardened-gcc

	if use alpha || use amd64 || use ia64 || use hppa; then
		append-flags -fPIC
	fi

	gst-plugins_src_configure --program-suffix=-${PV_MAJ_MIN}

	emake || die

}

DOCS="AUTHORS COPYING INSTALL README RELEASE TODO"

pkg_postinst () {

	gnome2_pkg_postinst
	gst-plugins_pkg_postinst

	echo ""
	einfo "The Gstreamer plugins setup has changed quite a bit on Gentoo,"
	einfo "applications now should provide you with the basic plugins."
	echo ""
	einfo "Right now this package installs at least an OSS output plugin to have"
	einfo "a standard sound output plugin, but this might change in the future."
	echo ""
	einfo "The new seperate plugins are all named 'gst-plugins-<plugin>'."
	einfo "To get a listing of currently available plugins do 'emerge -s gst-plugins-'."
	einfo "In most cases it shouldn't be needed though to emerge extra plugins."

}

pkg_postrm() {

	gnome2_pkg_postrm
	gst-plugins_pkg_postrm

}
