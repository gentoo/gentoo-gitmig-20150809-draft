# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/x11-drm/x11-drm-4.3.0-r6.ebuild,v 1.2 2004/10/29 06:34:29 spyderous Exp $

# Small note:  we should prob consider using a DRM only tarball, as it will ease
#              some of the overhead on older systems, and will enable us to
#              update DRM if there are fixes not already in XFree86 tarballs ...

# Removing USE as soon as VIDEO_CARDS shows up in make.conf
IUSE="3dfx gamma i8x0 matrox rage128 radeon sis"
IUSE_VIDEO_CARDS="3dfx gamma i810 i830 matrox rage128 radeon sis"

inherit eutils x11

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
RESTRICT="nostrip"

SNAPSHOT="20030714"
PATCHVER="0.4"

MY_PF=${PF/x11/xfree}
S="${WORKDIR}/drm"
DESCRIPTION="Xfree86 Kernel DRM modules"
HOMEPAGE="http://dri.sf.net"
SRC_URI="mirror://gentoo/linux-drm-${PV}-kernelsource-${SNAPSHOT}.tar.gz
	mirror://gentoo/${MY_PF}-gentoo-${PATCHVER}.tar.bz2"

# These sources come from one of these places:
#
#   http://www.xfree86.org/~alanh/ -- DRM snapshots, outdated 
#   http://people.debian.org/~daenzer/ -- full tree, often patched but
#	somewhat outdated
#   http://dri.sourceforge.net/snapshots/ -- daily CVS snapshots, lacking
#	gamma and sis
#   http://dri.sourceforge.net CVS -- full tree
#   http://cvs.sourceforge.net/cvstarballs/dri-cvsroot.tar.gz -- backup
#   rsync -avz --delete rsync://mefriss1.swan.ac.uk/dri/ -- temporary
#
# We throw all necessary files into one folder and turn that into our tarball.

SLOT="${KV}"
LICENSE="X11"
KEYWORDS="x86 alpha ppc ia64"

# Need new portage for USE_EXPAND
DEPEND="virtual/x11
	virtual/linux-sources
	>=sys-apps/portage-2.0.49-r13"

PROVIDE="virtual/drm"

pkg_setup() {
	VIDCARDS=""

	if useq matrox || useq video_cards_matrox
	then
		VIDCARDS="${VIDCARDS} mga.o"
	fi
	if useq 3dfx || useq video_cards_3dfx
	then
		VIDCARDS="${VIDCARDS} tdfx.o"
	fi
	if useq rage128 || useq video_cards_rage128
	then
		VIDCARDS="${VIDCARDS} r128.o"
	fi
	if useq radeon || useq video_cards_radeon
	then
		VIDCARDS="${VIDCARDS} radeon.o"
	fi
	if useq sis || useq video_cards_sis
	then
		VIDCARDS="${VIDCARDS} sis.o"
	fi
	if useq i8x0
	then
		VIDCARDS="${VIDCARDS} i810.o i830.o"
	fi
	if useq gamma || useq video_cards_gamma
	then
		VIDCARDS="${VIDCARDS} gamma.o"
	fi

	useq video_cards_i810 && VIDCARDS="${VIDCARDS} i810.o"
	useq video_cards_i830 && VIDCARDS="${VIDCARDS} i830.o"
}

src_unpack() {
	# 2.6 kernels are broken for now
	is_kernel "2" "6" && \
		die "Please link ${ROOT}/usr/src/linux to 2.4 kernel sources. x11-drm is not yet working with 2.6 kernels, use the DRM in the kernel."

	# Is this necessary with the fixed Makefile?
	if [ ! -f ${ROOT}/usr/src/linux/include/config/MARKER ] ; then
		die "Please compile kernel sources with \"make bzImage.\""
	fi

	# Require at least one video card.
	if [ -z "${VIDCARDS}" ] ; then
		die "Please set at least one video card in VIDEO_CARDS in make.conf or the environment. USE is deprecated. Possible VIDEO_CARDS values are matrox, 3dfx, rage128, radeon, sis, i810, i830, and gamma."
	fi

	unpack ${A}
	cd ${S}

	local PATCHDIR=${WORKDIR}/patch

	epatch ${PATCHDIR}/${MY_PF}-gentoo-Makefile-fixup.patch
	epatch ${PATCHDIR}/${MY_PF}-dristat.patch
	# For kernels that lack a vmap() implementation taking four arguments, which
	#the DRM requires for using agpgart with AGP bridges that don't provide
	#direct CPU access to the AGP aperture.
	[ "${ARCH}" = "ppc" ] && \
		epatch ${PATCHDIR}/${MY_PF}-drm-ioremap.patch

	# Fix for bug #25598
	[ "${ARCH}" = "ppc" ] && \
		epatch ${PATCHDIR}/${MY_PF}-rage128-timeout.patch

# Pfeifer said this patch is ok for any kernel >= 2.4 <spyderous>
#	if [ "${KV_major}" -eq 2 -a "${KV_minor}" -eq 4 ] && \
	if [ -r ${ROOT}/usr/src/linux/mm/rmap.c ]
	then
		einfo "Detected rmap enabled kernel."
		EPATCH_SINGLE_MSG="Applying rmap patch..." \
		epatch ${PATCHDIR}/${MY_PF}-pte_offset.diff
	fi

# Fix for 2.5 kernels
#	if [ "${KV_major}" -eq 2 -a "${KV_minor}" -eq 5 ]
#	then
#		EPATCH_SINGLE_MSG="Applying patch for kernel 2.5..." \
#		epatch ${PATCHDIR}/${MY_PF}-drm_2.5.diff
#	fi

}

src_compile() {
	check_KV
	ln -sf Makefile.linux Makefile
	einfo "Building DRM..."
	make ${VIDCARDS} \
		TREE="${ROOT}/usr/src/linux/include" KV="${KV}"
	make dristat || die
}

src_install() {

	einfo "installing DRM..."
	make \
		TREE="${ROOT}/usr/src/linux/include" \
		KV="${KV}" \
		DESTDIR="${D}" \
		MODS="${VIDCARDS}" \
		install || die
	dodoc README*
	exeinto /usr/X11R6/bin
	doexe dristat

	einfo "Stripping binaries..."
	# This bit I got from Redhat ... strip binaries and drivers ..
	# NOTE:  We do NOT want to strip the drivers, modules or DRI modules!
	for x in $(find ${D}/ -type f -perm +0111 -exec file {} \; | \
		grep -v ' shared object,' | \
		sed -n -e 's/^\(.*\):[  ]*ELF.*, not stripped/\1/p')
	do
	if [ -f ${x} ]
		then
			# Dont do the modules ...
			if [ "${x/\/lib\/modules}" = "${x}" ]
			then
				echo "`echo ${x} | sed -e "s|${D}||"`"
				strip ${x} || :
			fi
		fi
	done

}

pkg_postinst() {

	if [ "${ROOT}" = "/" ]
	then
		/sbin/modules-update
	fi
	if [ -z "VIDEO_CARDS" ]
	then
		einfo "USE is deprecated. Please set your video cards using VIDEO_CARDS."
		einfo "Possible VIDEO_CARDS values are: ${IUSE_VIDEO_CARDS}."
		echo
	fi

	if use video_cards_sis
	then
		einfo "SiS direct rendering only works on 300/305, 540, 630/S/ST, 730/S chipsets."
		einfo "SiS framebuffer also needs to be enabled in the kernel."
		echo
	fi

	ewarn "If you used genkernel to compile your kernel, you must change"
	ewarn "your processor type to something greater than 386."
}
