# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-lib/alsa-lib-1.0.5-r2.ebuild,v 1.5 2004/07/19 10:01:41 eradicator Exp $

inherit libtool

DESCRIPTION="Advanced Linux Sound Architecture Library"
HOMEPAGE="http://www.alsa-project.org/"

SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~amd64 -sparc ~ia64"
LICENSE="GPL-2 LGPL-2.1"

IUSE="static jack"

RDEPEND="virtual/alsa"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7.2"

PDEPEND="!ppc? ( jack? ( =media-plugins/alsa-jack-${PV}* ) )"

MY_P=${P/_rc/rc}
#SRC_URI="ftp://ftp.alsa-project.org/pub/lib/${MY_P}.tar.bz2"
SRC_URI="mirror://alsaproject/lib/${MY_P}.tar.bz2"
S=${WORKDIR}/${MY_P}

#pkg_setup() {
pkg_postinst() {
	# This is kinda hackish, so if someone else has a better idea,
	# feel free to implement it.  We need to detect if /usr/include/sound
	# exists.  If it does, then we leave it alone.  If it doesn't, we
	# assume virtual/alsa was satisfied by 2.6 sources and setup a symlink.
	# If they emerge alsa-driver, then the real dir with overwrite the symlink.

	if ! [ -e /usr/include/sound ]; then
		if [ -d /usr/src/linux/include/sound ]; then
			ln -s /usr/src/linux/include/sound /usr/include/sound
		else
			eerror "You don't seem to have valid alsa (driver) headers installed at /usr/include/sound."
			eerror "and I couldn't find any at /usr/src/linux/include/sound to use either.  Please"
			eerror "emerge alsa-driver or setup /usr/src/linux to point to a valid 2.6.x kernel"
			eerror "then run ln -s /usr/src/linux/include/sound /usr/include/sound"
		fi
	fi

	einfon "Checking sound headers for broken asound.h ... "
	if ! gcc -c ${FILESDIR}/test-asound_h.c -o ${T}/test1.o &> /dev/null; then
		echo "yes"
		eerror "Your version of:"
		eerror "  /usr/include/sound/asound.h"
		eerror "is broken (from a user space perspective).  Programs which"
		eerror "rely on the alsa driver headers will fail to compile. Please"
		eerror "apply the following patch:"
		echo
		eerror "*******************************************************"
		cat ${FILESDIR}/fix-asound_h.patch
		eerror "*******************************************************"
		echo
		eerror "You should be able to do this by issuing the following commands:"
		eerror "cd /usr/include/sound"
		eerror "patch -p0 < ${FILESDIR}/fix-asound_h.patch"
		echo
		eerror "If that doesn't work, please apply the patch by hand by"
		eerror "editing /usr/include/sound/asound.h in a text editor."
		echo
#		die "Broken sound/asound.h header included in kernel sources!"

		eerror "Continuting in 10 seconds to let you read this note: "
		for d in 10 9 8 7 6 5 4 3 2 1; do
			echo -n "$d "
			sleep 1
		done
		echo
	else
		echo "no"
	fi
}

src_unpack() {
	unpack ${A}

	if use static; then
		mv ${S} ${S}.static
		unpack ${A}

		cd ${S}.static
		elibtoolize
	fi

	cd ${S}
	elibtoolize
}

src_compile() {
	local myconf=""

	econf --enable-static=no --enable-shared=yes || die
	emake || die

	# Can't do both according to alsa docs and bug #48233
	if use static; then
		cd ${S}.static
		econf --enable-static=yes --enable-shared=no || die
		emake || die
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	#This alsa version does not provide libasound.so.1
	#Without this library just about everything even remotely
	#linked to previous versions of alsa-lib will break.
	#Fortunately, libasound.so.2 seems to be backwards
	#compatible with libasound.so.1 and a simple link
	#fixes the problem (fingers crossed)
	dosym /usr/lib/libasound.so.2 /usr/lib/libasound.so.1
	dodoc ChangeLog COPYING TODO

	if use static; then
		cd ${S}.static
		make DESTDIR="${D}" install || die "make install failed"
	fi
}
