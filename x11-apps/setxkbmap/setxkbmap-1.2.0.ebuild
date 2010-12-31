# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/setxkbmap/setxkbmap-1.2.0.ebuild,v 1.7 2010/12/31 20:52:28 jer Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="Controls the keyboard layout of a running X server."

KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""
RDEPEND="x11-libs/libxkbfile
	x11-libs/libX11"
DEPEND="${RDEPEND}"
