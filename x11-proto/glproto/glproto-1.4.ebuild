# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/glproto/glproto-1.4.ebuild,v 1.6 2005/08/10 06:50:08 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

OPENGL_DIR="xorg-x11"

DESCRIPTION="X.Org GL protocol headers"
#HOMEPAGE="http://foo.bar.com/"
#SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"
#LICENSE=""
#SLOT="0"
KEYWORDS="~sparc ~x86"
#IUSE="X gnome"
DEPEND=">=x11-base/opengl-update-2.2.2"
#RDEPEND=""

src_install() {
	x-modular_src_install

	dynamic_libgl_install
}

pkg_postinst() {
	switch_opengl_implem
}

dynamic_libgl_install() {
	# next section is to setup the dynamic libGL stuff
	ebegin "Moving GL files for dynamic switching"
		dodir /usr/$(get_libdir)/opengl/${OPENGL_DIR}/include
		local x=""
		# glext.h added for #54984
		# glx.h also provided by mesa, so we don't add it
		rm ${D}/usr/include/GL/{glx,glu}.h
		for x in ${D}/usr/include/GL/{glxtokens.h,glxmd.h,glxproto.h}; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f ${x} ${D}/usr/$(get_libdir)/opengl/${OPENGL_DIR}/include
			fi
		done
	eend 0
}

switch_opengl_implem() {
		# Switch to the xorg implementation.
		# Use new opengl-update that will not reset user selected
		# OpenGL interface ...
		echo
		local opengl_implem="$(${ROOT}/usr/sbin/opengl-update --get-implementation)"
		${ROOT}/usr/sbin/opengl-update --use-old ${OPENGL_DIR}
}
