# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree-drm/xfree-drm-4.3.0-r8.ebuild,v 1.7 2004/07/26 20:16:19 spyderous Exp $

IUSE="gatos"
IUSE_VIDEO_CARDS="3dfx gamma i810 i830 matrox rage128 radeon sis mach64"

inherit eutils xfree
# pending latexer committing koutput stuff
#inherit kmod

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
RESTRICT="nostrip"

SNAPSHOT="20031202"
PATCHVER="0.4"
PATCHDIR="${WORKDIR}/patch"
EXCLUDED="${PATCHDIR}/excluded"
S="${WORKDIR}/drm"
DESCRIPTION="XFree86 Kernel DRM modules"
HOMEPAGE="http://dri.sf.net"
# Use the same patchset for all of them; exclude patches as necessary
SRC_URI="mirror://gentoo/${PF}-gentoo-${PATCHVER}.tar.bz2
	mirror://gentoo/linux-drm-${PV}-kernelsource-${SNAPSHOT}.tar.bz2
	gatos? ( mirror://gentoo/linux-drm-gatos-${PV}-kernelsource-${SNAPSHOT}.tar.bz2 )
	video_cards_mach64? ( mirror://gentoo/linux-drm-mach64-${PV}-kernelsource-${SNAPSHOT}.tar.bz2 )"

# These sources come from one of these places:
#
#   http://www.xfree86.org/~alanh/ -- Makefile.linux from DRM snapshots
#   http://people.debian.org/~daenzer/ -- drm-ioremap patch
#   http://dri.sourceforge.net CVS -- xc/xc/programs/Xserver/hw/os-support
#		-- the CVS is at freedesktop.org now, but webpage is still sourceforge
#
# We throw all necessary files into one folder and turn that into our tarball.
# find os-support/ -name *.[ch] -exec cp {} drm/ \;
# find os-support/linux/drm/kernel/ -maxdepth 1 -type f -exec cp {} drm/ \;

SLOT="${KV}"
LICENSE="X11"
KEYWORDS="~x86"

# Need new portage for USE_EXPAND
DEPEND="virtual/x11
	virtual/linux-sources
	>=sys-apps/portage-2.0.49-r13"

PROVIDE="virtual/drm"

pkg_setup() {
	# mach64 is exclusive of other modules
	check_exclusive mach64

	# Require at least one video card
	if [ -z "${VIDEO_CARDS}" ]
	then
		die "Please set at least one video card in VIDEO_CARDS in make.conf or the environment. Possible VIDEO_CARDS values are: ${IUSE_VIDEO_CARDS}."
	fi

	# gatos doesn't build on anything but radeon
	if use gatos
	then
		if ! use video_cards_radeon -a ! use video_cards_rage128
		then
			die "Remove gatos from your USE flags. It does not build for cards other than radeon and rage128."
		fi
		is_kernel 2 6 && die "GATOS does not work with 2.6 kernels. Please use a 2.4 kernel."
	fi

	# Set video cards to build for
	set_vidcards

	return 0
}

src_unpack() {
	if use gatos
	then
		unpack linux-drm-gatos-${PV}-kernelsource-${SNAPSHOT}.tar.bz2
		unpack ${PF}-gentoo-${PATCHVER}.tar.bz2
	elif use video_cards_mach64
	then
		unpack linux-drm-mach64-${PV}-kernelsource-${SNAPSHOT}.tar.bz2
		unpack ${PF}-gentoo-${PATCHVER}.tar.bz2
	else # standard case
		unpack linux-drm-${PV}-kernelsource-${SNAPSHOT}.tar.bz2
		unpack ${PF}-gentoo-${PATCHVER}.tar.bz2
	fi

	cd ${S}

	# Move AGP checker and alanh's Makefile over
	cp ${PATCHDIR}/picker.c ${S}
	is_kernel 2 4 && cp ${PATCHDIR}/Makefile.linux-2.4 ${S}/Makefile.linux
	is_kernel 2 6 && cp ${PATCHDIR}/Makefile.linux-2.6 ${S}/Makefile.linux

	patch_prepare

	# Apply patches
	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}
	sed -ie "s:/kernel/drivers/char/drm:/xfree-drm:g" Makefile.linux
}

src_compile() {
#	get_kernel_info
	ln -sf Makefile.linux Makefile
	if is_kernel 2 6
	then
		einfo "Building DRM (${VIDCARDS}) for kernel 2.6..."
		unset ARCH
		make -f Makefile.linux \
			DRM_MODULES="${VIDCARDS}" \
			LINUXDIR=${ROOT}/usr/src/linux \
			LINUXOUTPUT=${KV_OUTPUT} \
			modules || die "Build failed."
	else
		einfo "Building DRM for kernel 2.4..."
		make ${VIDCARDS} \
			TREE="${ROOT}/usr/src/linux/include" KV="${KV}" || die "Build failed."
	fi

	# Build dristat utility (bug #18799)
	# But, don't do it if the GATOS drivers are being built, since it won't work
	if ! use gatos
	then
		make dristat || die
	fi
}

src_install() {
	einfo "installing DRM..."
	if is_kernel 2 6
	then
		MYARCH="$ARCH"
		if [ "$ARCH" = "x86" ]
		then
			MYARCH="i386"
		fi
		make -f Makefile.linux \
			KV="${KV}" \
			LINUXDIR=${ROOT}/usr/src/linux \
			LINUXOUTPUT=${KV_OUTPUT} \
			MODS="${VIDCARDS}" \
			ARCH="${MYARCH}" \
			DESTDIR="${D}" \
			install || die "Install failed."
	else
		make \
			TREE="${ROOT}/usr/src/linux/include" \
			KV="${KV}" \
			DESTDIR="${D}" \
			MODS="${VIDCARDS}" \
			install || die "Install failed."
	fi
	dodoc README*
	if ! use gatos
	then
		exeinto /usr/X11R6/bin
		doexe dristat

		# Strip binaries, leaving /lib/modules untouched (bug #24415)
		strip_bins \/lib\/modules
	fi

	# Yoinked from the sys-apps/touchpad ebuild. Thanks to whoever made this.
	keepdir /etc/modules.d
	sed 's:%KV%:'${KV}':g' ${FILESDIR}/modules.d-${PN} > ${D}/etc/modules.d/${PN}
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		/sbin/modules-update
	fi

	if use video_cards_sis
	then
		einfo "SiS direct rendering only works on 300 series chipsets."
		einfo "SiS framebuffer also needs to be enabled in the kernel."
	fi

	if use video_cards_mach64
	then
		ewarn "The Mach64 DRI driver is insecure."
		ewarn "Malicious clients can write to system memory."
		ewarn "For more information, see:"
		ewarn "http://dri.sourceforge.net/cgi-bin/moin.cgi/ATIMach64?value=CategoryHardwareChipset."
	fi
}


# Functions used earlier are defined below.

check_exclusive() {
	# If a certain module is being built, don't allow any others.
	# Most useful for mach64, since it must be built exclusively
	# since the two directories are both named drm to make ${S} easier

	local x
	local c="0"
	if use video_cards_${1}
	then
		for x in ${IUSE_VIDEO_CARDS}
		do
			if use video_cards_${x}
			then
				c="`expr ${c} + 1`"
				if [ "${c}" -ge "2" ]
				then
					die "You cannot build for ${1} and any other card at the same time."
				fi
			fi
		done
	fi
}

set_vidcards() {
	get_kernel_info
	VIDCARDS=""

	use video_cards_matrox && \
		VIDCARDS="${VIDCARDS} mga.${KV_OBJ}"
	use video_cards_3dfx && \
		VIDCARDS="${VIDCARDS} tdfx.${KV_OBJ}"
	use video_cards_rage128 && \
		VIDCARDS="${VIDCARDS} r128.${KV_OBJ}"
	use video_cards_radeon && \
		VIDCARDS="${VIDCARDS} radeon.${KV_OBJ}"
	use video_cards_sis && \
		VIDCARDS="${VIDCARDS} sis.${KV_OBJ}"
	use video_cards_i810 && \
		VIDCARDS="${VIDCARDS} i810.${KV_OBJ}"
	use video_cards_i830 && \
		VIDCARDS="${VIDCARDS} i830.${KV_OBJ}"
	use video_cards_gamma && \
		VIDCARDS="${VIDCARDS} gamma.${KV_OBJ}"
	use video_cards_mach64 && \
		VIDCARDS="${VIDCARDS} mach64.${KV_OBJ}"
}

patch_prepare() {
	# Do patch excluding based on standard, mach64 or gatos here.
	# Works everywhere:
	# 002_all_dristat-compile-fix.patch

	is_kernel 2 4 && mv -f ${PATCHDIR}/*2.6* ${EXCLUDED}
	is_kernel 2 6 && mv -f ${PATCHDIR}/*2.4* ${EXCLUDED}

	if use video_cards_mach64
	then
		einfo "Updating for mach64 build..."
		# Also exclude all non-mach64 patches
		# mv -f ${PATCHDIR}/3* ${EXCLUDED}
		mv -f ${PATCHDIR}/004* ${EXCLUDED}
		mv -f ${PATCHDIR}/1* ${EXCLUDED}
		mv -f ${PATCHDIR}/3* ${EXCLUDED}
	elif use gatos
	then
		einfo "Updating for gatos build..."
		# This Makefile.linux might be more work to port to alanh's version
		# Exclude all non-gatos patches
		mv -f ${PATCHDIR}/004* ${EXCLUDED}
		mv -f ${PATCHDIR}/1* ${EXCLUDED}
		mv -f ${PATCHDIR}/2* ${EXCLUDED}
	else # standard case
		einfo "Updating for standard build..."
		# Exclude all gatos or mach64 patches
		mv -f ${PATCHDIR}/2* ${EXCLUDED}
		mv -f ${PATCHDIR}/3* ${EXCLUDED}
	fi
}
