# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/opengl-update/opengl-update-1.8.1.ebuild,v 1.3 2004/07/31 07:34:54 spyderous Exp $

DESCRIPTION="Utility to change the OpenGL interface being used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~ia64 ~ppc64"
IUSE=""
GLEXT="20040714"

DEPEND="virtual/libc"

pkg_setup() {
	# xfree has glext.h somewhere out of place so lets make the user move it
	if ( [ ! -h /usr/X11R6/include/GL/glext.h ] && [ -a /usr/X11R6/include/GL/glext.h ] )
	then
		# Just make it simpler on the user by giving verbose instructions
		if [ -d /usr/lib/opengl/xfree ]
		then
			GL_IM="xfree"
		else
			GL_IM="xorg-x11"
		fi

		echo
		ewarn "Due to inconsistencies in xorg-x11 vs xfree handling of glext.h a userspace"
		ewarn "is necessary for you to use opengl-update-1.8; Please do the following"
		echo
		ewarn "mv /usr/X11R6/include/GL/glext.h /usr/lib/opengl/${GL_IM}/include"
		echo
		ewarn "You may then remerge opengl-update-1.8 successfully"
		echo

		die "Userspace problem needs fixing"
	fi
}

src_install() {
	newsbin ${FILESDIR}/opengl-update-${PV} opengl-update || die

	# Install default glext.h
	dodir /usr/lib/opengl/global/include
	insinto /usr/lib/opengl/global/include
	newins ${FILESDIR}/glext.h-${GLEXT} glext.h || die
}
