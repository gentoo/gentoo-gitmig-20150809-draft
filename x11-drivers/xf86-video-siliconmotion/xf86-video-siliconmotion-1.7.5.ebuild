# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-siliconmotion/xf86-video-siliconmotion-1.7.5.ebuild,v 1.6 2012/03/18 15:54:44 chithanh Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Silicon Motion video driver"

KEYWORDS="alpha amd64 ia64 ~mips x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.7.5-xorg-server-1.12.patch
	"${FILESDIR}"/${PN}-1.7.5-abi-check.patch
	"${FILESDIR}"/${PN}-1.7.5-new-vgahw.patch
)
