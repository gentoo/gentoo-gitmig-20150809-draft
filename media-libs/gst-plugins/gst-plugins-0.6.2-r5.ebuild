# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins/gst-plugins-0.6.2-r5.ebuild,v 1.1 2003/06/16 22:17:17 foser Exp $

# IMPORTANT
#
# Since gst-plugins uses a local copy of ffmpeg we consider this a non-external plugin
# In essence this means gst-plugins without any external plugins already provides a 
# wide range of audio/video codecs
#
# This may change in the future, but for now 3rd-party apps do probably not need to depend
# on mpeg/avi plugins etcetera unless they directly name specific plugins

inherit gnome2 gst-plugins eutils flag-o-matic

DESCRIPTION="Additional plugins for gstreamer"
HOMEPAGE="http://gstreamer.net"

LICENSE="GPL-2"
KEYWORDS="~x86"

# TODO : gconf support is also optional

RDEPEND="=media-libs/gstreamer-${PV}*
	>=gnome-base/gconf-1.2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

BUILD_GST_PLUGIN="ffmpeg"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}
	# ppc asm included in the resample plugin seems to be broken, 
	# using a slower but working version for now
	epatch ${FILESDIR}/noppcasm.patch

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

	gst-plugins_src_configure --program-suffix=-${PV_MAJ_MIN}
	
	emake || die

}

src_install() {

	einstall || die

	dodoc AUTHORS COPYING INSTALL README RELEASE TODO
}

pkg_postinst () {

	gnome2_pkg_postinst
	gst-plugins_pkg_postinst

}

pkg_postrm() {

	gnome2_pkg_postrm
	gst-plugins_pkg_postrm

}
