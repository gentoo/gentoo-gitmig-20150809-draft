# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/x11-drm/x11-drm-4.3.0-r7.ebuild,v 1.8 2006/04/16 20:16:03 spyderous Exp $

IUSE="gatos"
IUSE_VIDEO_CARDS="3dfx gamma i810 i830 mga r128 radeon sis mach64"

inherit eutils x11

# Make sure Portage does _NOT_ strip symbols.  We will do it later and make sure
# that only we only strip stuff that are safe to strip ...
RESTRICT="nostrip"

MY_PF=${PF/x11/xfree}
SNAPSHOT="20031202"
# Should probably renumber 010 to 100 and 040 to 140 for next patchset
PATCHVER="0.4"
PATCHDIR="${WORKDIR}/patch"
EXCLUDED="${PATCHDIR}/excluded"
S="${WORKDIR}/drm"
DESCRIPTION="XFree86 Kernel DRM modules"
HOMEPAGE="http://dri.sf.net"
# Use the same patchset for all of them; exclude patches as necessary
SRC_URI="mirror://gentoo/${MY_PF}-gentoo-${PATCHVER}.tar.bz2
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
KEYWORDS="x86 alpha ia64 ppc"

# Need new portage for USE_EXPAND
DEPEND="virtual/linux-sources
	>=sys-apps/portage-2.0.49-r13"

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
		if ! use video_cards_radeon && ! use video_cards_r128
		then
			die "Remove gatos from your USE flags. It does not build for cards other than radeon and r128."
		fi
	fi

	# 2.6 kernels are broken for now
	is_kernel 2 6 && \
		die "Please link ${ROOT}/usr/src/linux to 2.4 kernel sources. x11-drm does not yet work with 2.6 kernels, use the DRM in the kernel."

	# Force at least make dep (this checks for bzImage, actually) (bug #22853)
	if [ ! -f ${ROOT}/usr/src/linux/include/config/MARKER ]
	then
		die "Please compile kernel sources with \"make bzImage\"."
	fi

	# Set video cards to build for
	set_vidcards

	return 0
}

src_unpack() {
	if use gatos
	then
		unpack linux-drm-gatos-${PV}-kernelsource-${SNAPSHOT}.tar.bz2
	elif use video_cards_mach64
	then
		unpack linux-drm-mach64-${PV}-kernelsource-${SNAPSHOT}.tar.bz2
	else # standard case
		unpack linux-drm-${PV}-kernelsource-${SNAPSHOT}.tar.bz2
	fi

	unpack ${MY_PF}-gentoo-${PATCHVER}.tar.bz2

	cd ${S}

	# Move AGP checker and alanh's Makefile over
	cp ${PATCHDIR}/picker.c ${S}
	cp ${PATCHDIR}/Makefile.linux ${S}

	patch_prepare

	# Apply patches
	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}

	# Change the install location for the modules.d stuff
	sed -ie "s:/kernel/drivers/char/drm:/${PN}:g" Makefile.linux
	sed -ie "s:xfree-drm:${PN}:g" Makefile
}

src_compile() {
	ln -sf Makefile.linux Makefile
	einfo "Building DRM..."
	make ${VIDCARDS} \
		TREE="${ROOT}/usr/src/linux/include" KV="${KV}"
	# Build dristat utility (bug #18799)
	# But, don't do it if the GATOS drivers are being built, since it won't work
	if ! use gatos
	then
		make dristat || die
	fi
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
	if ! use gatos
	then
		exeinto /usr/X11R6/bin
		doexe dristat

		# Strip binaries, leaving /lib/modules untouched (bug #24415)
		strip_bins \/lib\/modules
	fi

	# Shamelessly stolen from the sys-apps/thinkpad ebuild. Thanks!
	keepdir /etc/modules.d
	sed 's:%PN%:'${PN}':g' ${FILESDIR}/modules.d-${PN} > ${D}/etc/modules.d/${PN}
	sed -i 's:%KV%:'${KV}':g' ${D}/etc/modules.d/${PN}
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
	VIDCARDS=""

	use video_cards_mga && \
		VIDCARDS="${VIDCARDS} mga.o"
	use video_cards_3dfx && \
		VIDCARDS="${VIDCARDS} tdfx.o"
	use video_cards_r128 && \
		VIDCARDS="${VIDCARDS} r128.o"
	use video_cards_radeon && \
		VIDCARDS="${VIDCARDS} radeon.o"
	use video_cards_sis && \
		VIDCARDS="${VIDCARDS} sis.o"
	use video_cards_i810 && \
		VIDCARDS="${VIDCARDS} i810.o"
	use video_cards_i830 && \
		VIDCARDS="${VIDCARDS} i830.o"
	use video_cards_gamma && \
		VIDCARDS="${VIDCARDS} gamma.o"
	use video_cards_mach64 && \
		VIDCARDS="${VIDCARDS}  mach64.o"
}

patch_prepare() {
	# Do patch excluding based on standard, mach64 or gatos here.
	# 001-099: Patches used in multiple sources
	# 100-199: Standard-only patches
	# 200-299: Mach64 patches
	# 300-399: Gatos patches
	# Convention for excluding is to use the full patch number, or * for groups

	# if [ ! "`is_kernel 2 6`" ]
	# then
	# 	mv -f ${PATCHDIR}/*2.6* ${EXCLUDED}
	# fi

	if use video_cards_mach64
	then
		einfo "Updating for mach64 build..."
		# Exclude all non-mach64 patches
		einfo "Excluding patches..."
			patch_exclude 040 1* 3*
		einfo "Done excluding patches"
	elif use gatos
	then
		einfo "Updating for gatos build..."
		# Exclude all non-gatos patches
		einfo "Excluding patches..."
			patch_exclude 010 040 1* 2*
		einfo "Done excluding patches"
	else # standard case
		einfo "Updating for standard build..."
		# Exclude all gatos or mach64 patches
		einfo "Excluding patches..."
			patch_exclude 2* 3*
		einfo "Done excluding patches"
	fi
}
