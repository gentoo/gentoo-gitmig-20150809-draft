# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfcalendar/xfcalendar-4.2.3.ebuild,v 1.14 2007/03/11 10:09:52 drac Exp $

inherit xfce42

DESCRIPTION="Calendar"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"

RDEPEND="x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	=xfce-base/xfce4-panel-4.2*
	=xfce-base/libxfce4mcs-4.2*
	=xfce-base/libxfcegui4-4.2*"

core_package
