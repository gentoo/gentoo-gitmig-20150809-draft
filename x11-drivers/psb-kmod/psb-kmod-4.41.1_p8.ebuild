# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/psb-kmod/psb-kmod-4.41.1_p8.ebuild,v 1.1 2009/09/13 20:10:43 patrick Exp $

EAPI="2"

inherit rpm linux-info linux-mod

DESCRIPTION="kernel module for the intel gma500 (poulsbo)"
HOMEPAGE="http://www.happyassassin.net/2009/05/13/native-poulsbo-gma-500-graphics-driver-for-fedora-10/"
SRC_URI="http://adamwill.fedorapeople.org/poulsbo/src/psb-kmod-4.41.1-8.fc11.src.rpm"

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
	kernel_is gt 2 6 28 && epatch "${WORKDIR}/${PN}_build.patch"

	if kernel_is gt 2 6 29; then
		epatch "${WORKDIR}/${PN}-4.41.1_irqreturn.patch"
		epatch "${WORKDIR}/${PN}-4.41.1_busid.patch"
	fi
}

src_compile()
{
	# dirty hack :(
	LINUXDIR=/usr/src/linux emake DRM_MODULES=psb || die
}

src_install()
{
	MODULE_NAMES="drm(kernel/drivers/gpu/drm:${S}:${S}) psb(kernel/drivers/gpu/drm:${S}:${S})"
	MODULESD_PSB_ALIASES=(
		"pci:v00008086d00008108sv*sd*bc*sc*i* psb"
		"pci:v00008086d00008109sv*sd*bc*sc*i* psb"
	)

	linux-mod_src_install
}
