# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-diskperf/xfce4-diskperf-2.1.0.ebuild,v 1.14 2007/10/26 13:22:07 angelos Exp $

inherit autotools xfce44

xfce44
xfce44_goodies_panel_plugin

DESCRIPTION="Disk usage and performance panel plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e "/^AC_INIT/s/diskperf_version()/diskperf_version/" configure.in
	eautoconf
}
