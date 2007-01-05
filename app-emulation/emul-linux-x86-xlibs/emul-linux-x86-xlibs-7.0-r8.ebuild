# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-xlibs/emul-linux-x86-xlibs-7.0-r8.ebuild,v 1.1 2007/01/05 10:25:51 vapier Exp $

inherit eutils

MY_P=${PN}-7.0-r5
DESCRIPTION="X11R6 libraries for emulation of 32bit x86 on amd64"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${MY_P}.tar.bz2
	mirror://gentoo/${P}-r7-emul.patch.bz2
	video_cards_i810? ( mirror://gentoo/emul-linux-x86-xlibs-i810_dri-${PV}.tar.bz2 )
	video_cards_mach64? ( mirror://gentoo/emul-linux-x86-xlibs-ati_dri-${PV}.tar.bz2 )
	video_cards_mga? ( mirror://gentoo/emul-linux-x86-xlibs-mga_dri-${PV}.tar.bz2 )
	video_cards_r128? ( mirror://gentoo/emul-linux-x86-xlibs-ati_dri-${PV}.tar.bz2 )
	video_cards_radeon? ( mirror://gentoo/emul-linux-x86-xlibs-ati_dri-${PV}.tar.bz2 )
	video_cards_s3virge? ( mirror://gentoo/emul-linux-x86-xlibs-s3virge_dri-${PV}.tar.bz2 )
	video_cards_savage? ( mirror://gentoo/emul-linux-x86-xlibs-savage_dri-${PV}.tar.bz2 )
	video_cards_sis? ( mirror://gentoo/emul-linux-x86-xlibs-sis_dri-${PV}.tar.bz2 )
	video_cards_tdfx? ( mirror://gentoo/emul-linux-x86-xlibs-tdfx_dri-${PV}.tar.bz2 )
	video_cards_trident? ( mirror://gentoo/emul-linux-x86-xlibs-trident_dri-${PV}.tar.bz2 )
	video_cards_via? ( mirror://gentoo/emul-linux-x86-xlibs-via_dri-${PV}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

IUSE_VIDEO_CARDS="
	video_cards_i810
	video_cards_mach64
	video_cards_mga
	video_cards_r128
	video_cards_radeon
	video_cards_s3virge
	video_cards_savage
	video_cards_sis
	video_cards_tdfx
	video_cards_trident
	video_cards_via"
IUSE="opengl ${IUSE_VIDEO_CARDS}"
RESTRICT="nostrip"

DEPEND=""
RDEPEND="opengl? ( app-admin/eselect-opengl )
	virtual/libc
	>=app-emulation/emul-linux-x86-baselibs-2.5.5-r2"

S=${WORKDIR}

pkg_preinst() {
	# Check for bad symlink before installing, bug 84441.
	if [[ -L ${ROOT}/emul/linux/x86/usr/lib/X11 ]] ; then
		rm -f "${ROOT}"/emul/linux/x86/usr/lib/X11
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	mkdir usr
	mv emul/linux/x86/usr/lib usr/lib32 || die
	rmdir emul/linux/x86/usr emul/linux/x86 emul/linux emul || die
	epatch ${P}-r7-emul.patch
	rm ${P}-r7-emul.patch || die
}

src_install() {
	cp -a "${WORKDIR}"/* "${D}"/ || die
}

pkg_postinst() {
	#update GL symlinks
	use opengl && /usr/bin/eselect opengl set --use-old
}
