# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/psb-kmod/psb-kmod-4.41.1_p10-r1.ebuild,v 1.1 2009/12/04 08:19:52 zmedico Exp $

EAPI="2"

inherit rpm linux-info linux-mod

DESCRIPTION="kernel module for the intel gma500 (poulsbo)"
HOMEPAGE="http://www.happyassassin.net/2009/09/26/gma-500-poulsbo-driver-for-fedora-11-soon-to-be-in-rpm-fusion/"
SRC_URI="http://download1.rpmfusion.org/nonfree/fedora/updates/testing/11/SRPMS/psb-kmod-4.41.1-10.fc11.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-drivers/psb-firmware"
RDEPEND=""

S=${WORKDIR}/psb-kernel-source-4.41.1

pkg_setup() {
	linux-mod_pkg_setup

	local CONFIG_CHECK="FB_CFB_FILLRECT FB_CFB_COPYAREA FB_CFB_IMAGEBLIT ~FRAMEBUFFER_CONSOLE !DRM"
	local ERROR_FB_CFB_FILLRECT="You don't have CONFIG_FB_CFB_FILLRECT enabled in you kernel config. To do this either hack drivers/video/Kconfig or enable an FB driver that pulls it in (for example VESAFB)"
	local ERROR_FB_CFB_COPYAREA="You don't have CONFIG_FB_CFB_FILLRECT enabled in you kernel config. To do this either hack drivers/video/Kconfig or enable an FB driver that pulls it in (for example VESAFB)"
	local ERROR_FB_CFB_IMAGEBLIT="You don't have CONFIG_FB_CFB_IMAGEBLIT enabled in you kernel config. To do this either hack drivers/video/Kconfig or enable an FB driver that pulls it in (for example VESAFB)"
	local WARNING_FBCON="You should really have CONFIG_FRAMEBUFFER_CONSOLE set in your kernel config. Otherwise you will get a seriously messed up console. You can work around this by loading the psb module with no_fb=1"

	check_extra_config

	linux_chkconfig_builtin "FRAMEBUFFER_CONSOLE" || ewarn "You really should not have CONFIG_FRAMEBUFFER_CONSOLE as a module. Otherwise you will get a seriously messed up console. You can work around this by loading the psb module with no_fb=1"
}

src_prepare()
{
	if kernel_is ge 2 6 29 ; then
		epatch "${WORKDIR}/psb-kmd-4.34-current_euid.patch"
		epatch "${WORKDIR}/psb-kernel-source-4.41.1-i2c-intelfb.patch"
	fi
	if kernel_is ge 2 6 30 ; then
		epatch "${WORKDIR}/${PN}-4.41.1_irqreturn.patch"
		epatch "${WORKDIR}/${PN}-4.41.1_busid.patch"
	fi
	if kernel_is ge 2 6 31 ; then
		epatch "${WORKDIR}/psb-kernel-source-4.41.1-agp_memory.patch"
	fi
	if kernel_is ge 2 6 32 ; then
		# In commit 6a12235c7d2d75c7d94b9afcaaecd422ff845ce0 phys_to_gart
		# was removed since it is a 1:1 mapping on all platforms.
		sed -e 's:phys_to_gart(page_to_phys(\*cur_page)):page_to_phys(*cur_page):' \
			-i drm_agpsupport.c || die "sed failed"
		# The PREFIX constant seems to be missing in 2.6.32.
		sed -e 's/KERN_ERR PREFIX/KERN_ERR "ACPI: "/' -i drm_edid.c \
			|| die "sed failed"
	fi
	epatch "${WORKDIR}/psb-kernel-source-4.41.1-drmpsb.patch"
}

src_compile()
{
	# dirty hack :(
	LINUXDIR=/usr/src/linux emake DRM_MODULES=psb || die
}

src_install()
{
	MODULE_NAMES="drm-psb(kernel/drivers/gpu/drm:${S}:${S}) psb(kernel/drivers/gpu/drm:${S}:${S})"
	MODULESD_PSB_ALIASES=(
		"pci:v00008086d00008108sv*sd*bc*sc*i* psb"
		"pci:v00008086d00008109sv*sd*bc*sc*i* psb"
	)

	linux-mod_src_install
}
