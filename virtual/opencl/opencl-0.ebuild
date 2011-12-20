# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/opencl/opencl-0.ebuild,v 1.1 2011/12/20 19:32:33 vapier Exp $

EAPI="4"

DESCRIPTION="Virtual for OpenCL implementations"

SLOT="0"
KEYWORDS="~amd64 ~x86"
CARDS=( fglrx nvidia )
IUSE="${CARDS[@]/#/video_cards_}"

REQUIRED_USE="|| ( ${IUSE} )"

RDEPEND="|| (
		video_cards_nvidia? ( x11-drivers/nvidia-drivers >=dev-util/nvidia-cuda-toolkit-3.1 )
		video_cards_fglrx? ( x11-drivers/ati-drivers[opencl] )
	)"
