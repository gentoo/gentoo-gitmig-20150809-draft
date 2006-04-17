# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xorg-x11/xorg-x11-7.0-r1.ebuild,v 1.21 2006/04/17 10:58:56 flameeyes Exp $

inherit eutils

DESCRIPTION="An X11 implementation maintained by the X.Org Foundation (meta package)"
HOMEPAGE="http://xorg.freedesktop.org"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE_INPUT_DEVICES="
	input_devices_acecad
	input_devices_aiptek
	input_devices_calcomp
	input_devices_citron
	input_devices_digitaledge
	input_devices_dmc
	input_devices_dynapro
	input_devices_elo2300
	input_devices_elographics
	input_devices_evdev
	input_devices_fpit
	input_devices_hyperpen
	input_devices_jamstudio
	input_devices_joystick
	input_devices_keyboard
	input_devices_magellan
	input_devices_magictouch
	input_devices_microtouch
	input_devices_mouse
	input_devices_mutouch
	input_devices_palmax
	input_devices_penmount
	input_devices_spaceorb
	input_devices_summa
	input_devices_tek4957
	input_devices_ur98
	input_devices_vmmouse
	input_devices_void

	input_devices_synaptics
	input_devices_wacom"
IUSE_VIDEO_CARDS="
	video_cards_apm
	video_cards_ark
	video_cards_chips
	video_cards_cirrus
	video_cards_cyrix
	video_cards_dummy
	video_cards_fbdev
	video_cards_glint
	video_cards_i128
	video_cards_i740
	video_cards_i810
	video_cards_imstt
	video_cards_mach64
	video_cards_mga
	video_cards_neomagic
	video_cards_newport
	video_cards_nsc
	video_cards_nv
	video_cards_r128
	video_cards_radeon
	video_cards_rendition
	video_cards_s3
	video_cards_s3virge
	video_cards_savage
	video_cards_siliconmotion
	video_cards_sis
	video_cards_sisusb
	video_cards_sunbw2
	video_cards_suncg14
	video_cards_suncg3
	video_cards_suncg6
	video_cards_sunffb
	video_cards_sunleo
	video_cards_suntcx
	video_cards_tdfx
	video_cards_tga
	video_cards_trident
	video_cards_tseng
	video_cards_v4l
	video_cards_vesa
	video_cards_vga
	video_cards_via
	video_cards_vmware
	video_cards_voodoo

	video_cards_nvidia
	video_cards_fglrx"
IUSE="${IUSE_VIDEO_CARDS}
	${IUSE_INPUT_DEVICES}
	3dfx"

# Collision protect will scream bloody murder if we install over old versions
RDEPEND="!<=x11-base/xorg-x11-6.9"

# Server
RDEPEND="${RDEPEND}
	>=x11-base/xorg-server-1.0.1"

# Common Applications
RDEPEND="${RDEPEND}
	>=x11-apps/mesa-progs-6.4.1
	>=x11-apps/setxkbmap-1.0.1
	>=x11-apps/xauth-1.0.1
	>=x11-apps/xhost-1
	>=x11-apps/xinit-1.0.1
	>=x11-apps/xmodmap-1
	>=x11-apps/xrandr-1.0.1"

# Common Libraries - move these to eclass eventually
RDEPEND="${RDEPEND}
	>=x11-libs/libSM-1
	>=x11-libs/libXcomposite-0.2.2.2
	>=x11-libs/libXcursor-1.1.5.2
	>=x11-libs/libXdamage-1.0.2.2
	>=x11-libs/libXfixes-3.0.1.2
	>=x11-libs/libXp-1
	>=x11-libs/libXv-1.0.1
	>=x11-libs/libXxf86dga-1
	>=x11-libs/libXinerama-1.0.1
	>=x11-libs/libXScrnSaver-1.0.1"

# Some fonts
RDEPEND="${RDEPEND}
	media-fonts/ttf-bitstream-vera
	>=media-fonts/font-bh-type1-1
	>=media-fonts/font-adobe-utopia-type1-1.0.1
	>=media-fonts/font-adobe-100dpi-1"

# Documentation
RDEPEND="${RDEPEND}
	>=app-doc/xorg-docs-1.0.1"

# We require a brand-new portage for the drivers section to work as expected,
# rather than pulling in absolutely nothing if VIDEO_CARDS is unset or ""
RDEPEND="${RDEPEND}
	>=sys-apps/portage-2.1_pre4"

# Drivers
###############################################################################
###############################################################################
##                                                                           ##
##   REMEMBER TO EDIT USE.MASK FILES IF CHANGING ARCHITECTURE DEPENDENCIES   ##
##                                                                           ##
###############################################################################
###############################################################################
RDEPEND="${RDEPEND}
	|| (
			(
				input_devices_acecad? ( x11-drivers/xf86-input-acecad )
				input_devices_aiptek? ( x11-drivers/xf86-input-aiptek )
				input_devices_calcomp? ( x11-drivers/xf86-input-calcomp )
				input_devices_citron? ( x11-drivers/xf86-input-citron )
				input_devices_digitaledge? ( x11-drivers/xf86-input-digitaledge )
				input_devices_dmc? ( x11-drivers/xf86-input-dmc )
				input_devices_dynapro? ( x11-drivers/xf86-input-dynapro )
				input_devices_elo2300? ( x11-drivers/xf86-input-elo2300 )
				input_devices_elographics? ( x11-drivers/xf86-input-elographics )
				input_devices_evdev? ( x11-drivers/xf86-input-evdev )
				input_devices_fpit? ( x11-drivers/xf86-input-fpit )
				input_devices_hyperpen? ( x11-drivers/xf86-input-hyperpen )
				input_devices_jamstudio? ( x11-drivers/xf86-input-jamstudio )
				input_devices_joystick? ( x11-drivers/xf86-input-joystick )
				input_devices_keyboard? ( x11-drivers/xf86-input-keyboard )
				input_devices_magellan? ( x11-drivers/xf86-input-magellan )
				input_devices_magictouch? ( x11-drivers/xf86-input-magictouch )
				input_devices_microtouch? ( x11-drivers/xf86-input-microtouch )
				input_devices_mouse? ( x11-drivers/xf86-input-mouse )
				input_devices_mutouch? ( x11-drivers/xf86-input-mutouch )
				input_devices_palmax? ( x11-drivers/xf86-input-palmax )
				input_devices_penmount? ( x11-drivers/xf86-input-penmount )
				input_devices_spaceorb? ( x11-drivers/xf86-input-spaceorb )
				input_devices_summa? ( x11-drivers/xf86-input-summa )
				input_devices_tek4957? ( x11-drivers/xf86-input-tek4957 )
				input_devices_ur98? ( x11-drivers/xf86-input-ur98 )
				input_devices_vmmouse? ( x11-drivers/xf86-input-vmmouse )
				input_devices_void? ( x11-drivers/xf86-input-void )

				input_devices_synaptics? ( x11-drivers/synaptics )
				input_devices_wacom? ( x11-misc/linuxwacom )
			)
			(
				x11-drivers/xf86-input-acecad
				x11-drivers/xf86-input-calcomp
				x11-drivers/xf86-input-citron
				x11-drivers/xf86-input-digitaledge
				x11-drivers/xf86-input-dmc
				x11-drivers/xf86-input-dynapro
				x11-drivers/xf86-input-elo2300
				x11-drivers/xf86-input-elographics
				x11-drivers/xf86-input-fpit
				x11-drivers/xf86-input-hyperpen
				x11-drivers/xf86-input-jamstudio
				x11-drivers/xf86-input-joystick
				x11-drivers/xf86-input-keyboard
				x11-drivers/xf86-input-magellan
				x11-drivers/xf86-input-magictouch
				x11-drivers/xf86-input-microtouch
				x11-drivers/xf86-input-mouse
				x11-drivers/xf86-input-mutouch
				x11-drivers/xf86-input-palmax
				x11-drivers/xf86-input-penmount
				x11-drivers/xf86-input-spaceorb
				x11-drivers/xf86-input-summa
				x11-drivers/xf86-input-tek4957
				x11-drivers/xf86-input-void

				kernel_linux? (
					x11-drivers/xf86-input-aiptek
					x11-drivers/xf86-input-evdev
					x11-drivers/xf86-input-ur98
				)

				x86? ( x11-drivers/xf86-input-vmmouse
					x11-drivers/synaptics
					x11-misc/linuxwacom
				)
				x86-fbsd? ( x11-drivers/xf86-input-vmmouse )
				amd64? ( x11-drivers/xf86-input-vmmouse
					x11-drivers/synaptics
					x11-misc/linuxwacom
				)
				ppc? ( x11-drivers/synaptics
					x11-misc/linuxwacom
				)
				ppc64? ( x11-drivers/synaptics
					x11-misc/linuxwacom
				)
			)
		)
	input_devices_synaptics? ( >=x11-drivers/synaptics-0.14.4-r2 )
	|| (
			(
				video_cards_apm? ( x11-drivers/xf86-video-apm )
				video_cards_ark? ( x11-drivers/xf86-video-ark )
				video_cards_chips? ( x11-drivers/xf86-video-chips )
				video_cards_cirrus? ( x11-drivers/xf86-video-cirrus )
				video_cards_cyrix? ( x11-drivers/xf86-video-cyrix )
				video_cards_dummy? ( x11-drivers/xf86-video-dummy )
				video_cards_fbdev? ( x11-drivers/xf86-video-fbdev )
				video_cards_glint? ( x11-drivers/xf86-video-glint )
				video_cards_i128? ( x11-drivers/xf86-video-i128 )
				video_cards_i740? ( x11-drivers/xf86-video-i740 )
				video_cards_i810? ( x11-drivers/xf86-video-i810 )
				video_cards_imstt? ( x11-drivers/xf86-video-imstt )
				video_cards_mach64? ( x11-drivers/xf86-video-ati )
				video_cards_mga? ( x11-drivers/xf86-video-mga )
				video_cards_neomagic? ( x11-drivers/xf86-video-neomagic )
				video_cards_newport? ( x11-drivers/xf86-video-newport )
				video_cards_nsc? ( x11-drivers/xf86-video-nsc )
				video_cards_nv? ( x11-drivers/xf86-video-nv )
				video_cards_r128? ( x11-drivers/xf86-video-ati )
				video_cards_radeon? ( x11-drivers/xf86-video-ati )
				video_cards_rendition? ( x11-drivers/xf86-video-rendition )
				video_cards_s3? ( x11-drivers/xf86-video-s3 )
				video_cards_s3virge? ( x11-drivers/xf86-video-s3virge )
				video_cards_savage? ( x11-drivers/xf86-video-savage )
				video_cards_siliconmotion? ( x11-drivers/xf86-video-siliconmotion )
				video_cards_sis? ( x11-drivers/xf86-video-sis )
				video_cards_sisusb? ( x11-drivers/xf86-video-sisusb )
				video_cards_sunbw2? ( x11-drivers/xf86-video-sunbw2 )
				video_cards_suncg14? ( x11-drivers/xf86-video-suncg14 )
				video_cards_suncg3? ( x11-drivers/xf86-video-suncg3 )
				video_cards_suncg6? ( x11-drivers/xf86-video-suncg6 )
				video_cards_sunffb? ( x11-drivers/xf86-video-sunffb )
				video_cards_sunleo? ( x11-drivers/xf86-video-sunleo )
				video_cards_suntcx? ( x11-drivers/xf86-video-suntcx )
				video_cards_tdfx? ( x11-drivers/xf86-video-tdfx )
				video_cards_tga? ( x11-drivers/xf86-video-tga )
				video_cards_trident? ( x11-drivers/xf86-video-trident )
				video_cards_tseng? ( x11-drivers/xf86-video-tseng )
				video_cards_v4l? ( x11-drivers/xf86-video-v4l )
				video_cards_vesa? ( x11-drivers/xf86-video-vesa )
				video_cards_vga? ( x11-drivers/xf86-video-vga )
				video_cards_via? ( x11-drivers/xf86-video-via )
				video_cards_vmware? ( x11-drivers/xf86-video-vmware )
				video_cards_voodoo? ( x11-drivers/xf86-video-voodoo )

				video_cards_3dfx? ( 3dfx? ( >=media-libs/glide-v3-3.10 ) )
				video_cards_nvidia? ( media-video/nvidia-glx )
				video_cards_fglrx? ( x11-drivers/ati-drivers )
			)
			(
				x11-drivers/xf86-video-dummy
				x11-drivers/xf86-video-fbdev

				!hppa? (
					x11-drivers/xf86-video-ati
					x11-drivers/xf86-video-mga

					x11-drivers/xf86-video-sisusb
					kernel_linux? ( x11-drivers/xf86-video-v4l )
				)

				3dfx? ( >=media-libs/glide-v3-3.10 )

				alpha? ( x11-drivers/xf86-video-cirrus
					x11-drivers/xf86-video-glint
					x11-drivers/xf86-video-nv
					x11-drivers/xf86-video-rendition
					x11-drivers/xf86-video-s3
					x11-drivers/xf86-video-s3virge
					x11-drivers/xf86-video-savage
					x11-drivers/xf86-video-siliconmotion
					x11-drivers/xf86-video-tdfx
					x11-drivers/xf86-video-tga
					x11-drivers/xf86-video-vga
					x11-drivers/xf86-video-voodoo )
				amd64? ( x11-drivers/xf86-video-apm
					x11-drivers/xf86-video-ark
					x11-drivers/xf86-video-chips
					x11-drivers/xf86-video-cirrus
					x11-drivers/xf86-video-cyrix
					x11-drivers/xf86-video-glint
					x11-drivers/xf86-video-i128
					x11-drivers/xf86-video-i810
					x11-drivers/xf86-video-neomagic
					x11-drivers/xf86-video-nv
					x11-drivers/xf86-video-rendition
					x11-drivers/xf86-video-s3
					x11-drivers/xf86-video-s3virge
					x11-drivers/xf86-video-savage
					x11-drivers/xf86-video-siliconmotion
					x11-drivers/xf86-video-sis
					x11-drivers/xf86-video-tdfx
					x11-drivers/xf86-video-tga
					x11-drivers/xf86-video-trident
					x11-drivers/xf86-video-tseng
					x11-drivers/xf86-video-vesa
					x11-drivers/xf86-video-vga
					x11-drivers/xf86-video-via
					x11-drivers/xf86-video-vmware
					x11-drivers/xf86-video-voodoo )
				arm? ( x11-drivers/xf86-video-chips
					x11-drivers/xf86-video-glint
					x11-drivers/xf86-video-nv
					x11-drivers/xf86-video-s3
					x11-drivers/xf86-video-s3virge
					x11-drivers/xf86-video-savage
					x11-drivers/xf86-video-sis
					x11-drivers/xf86-video-tdfx
					x11-drivers/xf86-video-trident
					x11-drivers/xf86-video-vga
					x11-drivers/xf86-video-voodoo )
				ia64? ( x11-drivers/xf86-video-apm
					x11-drivers/xf86-video-ark
					x11-drivers/xf86-video-chips
					x11-drivers/xf86-video-cirrus
					x11-drivers/xf86-video-cyrix
					x11-drivers/xf86-video-glint
					x11-drivers/xf86-video-i128
					x11-drivers/xf86-video-i740
					x11-drivers/xf86-video-i810
					x11-drivers/xf86-video-imstt
					x11-drivers/xf86-video-neomagic
					x11-drivers/xf86-video-nv
					x11-drivers/xf86-video-rendition
					x11-drivers/xf86-video-s3
					x11-drivers/xf86-video-s3virge
					x11-drivers/xf86-video-savage
					x11-drivers/xf86-video-siliconmotion
					x11-drivers/xf86-video-sis
					x11-drivers/xf86-video-tdfx
					x11-drivers/xf86-video-tga
					x11-drivers/xf86-video-trident
					x11-drivers/xf86-video-tseng
					x11-drivers/xf86-video-vesa
					x11-drivers/xf86-video-vga
					x11-drivers/xf86-video-via
					x11-drivers/xf86-video-voodoo )
				mips? ( x11-drivers/xf86-video-chips
					x11-drivers/xf86-video-cirrus
					x11-drivers/xf86-video-glint
					x11-drivers/xf86-video-newport
					x11-drivers/xf86-video-nv
					x11-drivers/xf86-video-s3
					x11-drivers/xf86-video-s3virge
					x11-drivers/xf86-video-savage
					x11-drivers/xf86-video-sis
					x11-drivers/xf86-video-tdfx
					x11-drivers/xf86-video-trident
					x11-drivers/xf86-video-voodoo )
				ppc? ( x11-drivers/xf86-video-chips
					x11-drivers/xf86-video-glint
					x11-drivers/xf86-video-imstt
					x11-drivers/xf86-video-nv
					x11-drivers/xf86-video-s3
					x11-drivers/xf86-video-s3virge
					x11-drivers/xf86-video-savage
					x11-drivers/xf86-video-sis
					x11-drivers/xf86-video-tdfx
					x11-drivers/xf86-video-trident
					x11-drivers/xf86-video-vga
					x11-drivers/xf86-video-voodoo )
				ppc64? ( x11-drivers/xf86-video-nv )
				sparc? (
					x11-drivers/xf86-video-glint
					x11-drivers/xf86-video-savage
					x11-drivers/xf86-video-sunbw2
					x11-drivers/xf86-video-suncg14
					x11-drivers/xf86-video-suncg3
					x11-drivers/xf86-video-suncg6
					x11-drivers/xf86-video-sunffb
					x11-drivers/xf86-video-sunleo
					x11-drivers/xf86-video-suntcx
					x11-drivers/xf86-video-tdfx
					x11-drivers/xf86-video-vesa
					x11-drivers/xf86-video-vga
					x11-drivers/xf86-video-voodoo )
				x86? ( x11-drivers/xf86-video-apm
					x11-drivers/xf86-video-ark
					x11-drivers/xf86-video-chips
					x11-drivers/xf86-video-cirrus
					x11-drivers/xf86-video-cyrix
					x11-drivers/xf86-video-glint
					x11-drivers/xf86-video-i128
					x11-drivers/xf86-video-i740
					x11-drivers/xf86-video-i810
					x11-drivers/xf86-video-imstt
					x11-drivers/xf86-video-neomagic
					x11-drivers/xf86-video-nsc
					x11-drivers/xf86-video-nv
					x11-drivers/xf86-video-rendition
					x11-drivers/xf86-video-s3
					x11-drivers/xf86-video-s3virge
					x11-drivers/xf86-video-savage
					x11-drivers/xf86-video-siliconmotion
					x11-drivers/xf86-video-sis
					x11-drivers/xf86-video-tdfx
					x11-drivers/xf86-video-tga
					x11-drivers/xf86-video-trident
					x11-drivers/xf86-video-tseng
					x11-drivers/xf86-video-vesa
					x11-drivers/xf86-video-vga
					x11-drivers/xf86-video-via
					x11-drivers/xf86-video-vmware
					x11-drivers/xf86-video-voodoo )
				x86-fbsd? (
					x11-drivers/xf86-video-vmware )
			)
		)"

DEPEND="${RDEPEND}"

src_install() {
	# Make /usr/X11R6 a symlink to ../usr.
	dodir /usr
	dosym ../usr /usr/X11R6
}

pkg_preinst() {
	# Check for /usr/X11R6 -> /usr symlink
	if [[ -e "/usr/X11R6" ]] &&
		[[ $(readlink "/usr/X11R6") != "../usr" ]]; then
			eerror "/usr/X11R6 isn't a symlink to ../usr. Please delete it."
			ewarn "First, save a list of all the packages installing there:"
			ewarn "		equery belongs /usr/X11R6 > usr-x11r6-packages"
			ewarn "This requires gentoolkit to be installed."
			die "/usr/X11R6 is not a symlink to ../usr."
	fi

	# Filter out ModulePath line since it often holds a now-invalid path
	# Bug #112924
	# For RC3 - filter out RgbPath line since it also seems to break things
	XORGCONF="/etc/X11/xorg.conf"
	if [ -e ${XORGCONF} ]; then
		mkdir -p "${IMAGE}/etc/X11"
		sed "/ModulePath/d" ${XORGCONF}	> ${IMAGE}${XORGCONF}
		sed -i "/RgbPath/d" ${IMAGE}${XORGCONF}
	fi
}

pkg_postinst() {
	# I'm not sure why this was added, but we don't inherit x-modular
	# x-modular_pkg_postinst

	echo
	einfo "Please note that the xcursors are in /usr/share/cursors/${PN}."
	einfo "Any custom cursor sets should be placed in that directory."
	echo
	einfo "If you wish to set system-wide default cursors, please create"
	einfo "/usr/local/share/cursors/${PN}/default/index.theme"
	einfo "with content: \"Inherits=theme_name\" so that future"
	einfo "emerges will not overwrite those settings."
	echo
	einfo "Listening on TCP is disabled by default with startx."
	einfo "To enable it, edit /usr/bin/startx."
	echo

	ewarn "Please read the modular X migration guide at"
	ewarn "http://www.gentoo.org/proj/en/desktop/x/x11/modular-x-howto.xml"
	echo
	einfo "If you encounter any non-configuration issues, please file a bug at"
	einfo "http://bugs.gentoo.org/enter_bug.cgi?product=Gentoo%20Linux"
	einfo "and attach /etc/X11/xorg.conf, /var/log/Xorg.0.log and emerge info"
	echo
	einfo "You can now choose which drivers are installed with the VIDEO_CARDS"
	einfo "and INPUT_DEVICES settings. Set these like any other Portage"
	einfo "variable in /etc/make.conf or on the command line."
	echo

	# (#76985)
	einfo "Visit http://www.gentoo.org/doc/en/index.xml?catid=desktop"
	einfo "for more information on configuring X."
	echo

	# Try to get people to read this, pending #11359
	ebeep 5
	epause 10
}
