# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xffm/xffm-4.2.3.ebuild,v 1.13 2007/03/11 10:06:30 drac Exp $

inherit xfce42

DESCRIPTION="File manager"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXt
	~xfce-base/xfce-mcs-manager-${PV}"
DEPEND="${RDEPEND}"

XFCE_CONFIG="--enable-all"
core_package
