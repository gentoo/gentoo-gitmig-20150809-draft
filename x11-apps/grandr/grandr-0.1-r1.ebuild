# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/grandr/grandr-0.1-r1.ebuild,v 1.1 2012/04/14 16:28:34 mgorny Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="GTK+-based tool to configure the X output using the RandR 1.2 extension"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""
RDEPEND="x11-libs/gtk+:2
	>=x11-libs/libXrandr-1.2
	gnome-base/gconf"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PV}-fix-license-display.patch
	"${FILESDIR}"/${PV}-outpus.patch
	"${FILESDIR}"/${PV}-fix-segfault-without-gconf-value.patch
)
