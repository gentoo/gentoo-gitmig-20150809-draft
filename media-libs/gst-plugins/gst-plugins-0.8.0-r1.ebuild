# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins/gst-plugins-0.8.0-r1.ebuild,v 1.2 2004/04/03 01:28:13 foser Exp $

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

IUSE="esd alsa oss"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~mips"

RDEPEND="=media-libs/gstreamer-${PV}*
	>=gnome-base/gconf-1.2"

DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.11.5
	>=dev-util/pkgconfig-0.9"

PDEPEND="oss? ( >=media-plugins/gst-plugins-oss-${PV} )
	alsa? ( >=media-plugins/gst-plugins-alsa-${PV} )
	esd? ( >=media-plugins/gst-plugins-esd-${PV} )"

# we need x for the x overlay to get linked
GST_PLUGINS_BUILD="x xshm"

src_unpack() {

	unpack ${A}

	cd ${S}
	# fix audioconvert (#
	epatch ${FILESDIR}/${P}-audioconvert_stereo.patch

	# ppc asm included in the resample plugin seems to be broken,
	# using a slower but working version for now
	#
	# ppc team : patch needs to be redone, also if this is _really_
	# a problem it should be sent upstream (why have ppc specific code 
	# if it doesn't work)
	# <foser@gentoo.org>
#	epatch ${FILESDIR}/noppcasm.patch

}

src_compile() {

	elibtoolize

	# gst doesnt handle optimisations well
	strip-flags
	replace-flags "-O3" "-O2"
	filter-flags "-fprefetch-loop-arrays" # see bug 22249
	if use alpha || use amd64 || use ia64 || use hppa; then
		append-flags -fPIC
	fi

	gst-plugins_src_configure

	emake || die

}

src_install() {

	gnome2_src_install

	# forgotten header, should be included next release
	insinto /usr/include/gstreamer-0.8/gst/xoverlay/
	doins ${S}/gst-libs/gst/xoverlay/xoverlay.h

}

DOCS="AUTHORS COPYING INSTALL README RELEASE TODO"

pkg_postinst () {

	gnome2_pkg_postinst
	gst-plugins_pkg_postinst

	echo ""
	einfo "The Gstreamer plugins setup has changed quite a bit on Gentoo,"
	einfo "applications now should provide the basic plugins needed."
	echo ""
	einfo "The new seperate plugins are all named 'gst-plugins-<plugin>'."
	einfo "To get a listing of currently available plugins execute 'emerge -s gst-plugins-'."
	einfo "In most cases it shouldn't be needed though to emerge extra plugins."

}

pkg_postrm() {

	gnome2_pkg_postrm
	gst-plugins_pkg_postrm

}
