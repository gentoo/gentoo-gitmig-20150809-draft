# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/editres/editres-1.0.5.ebuild,v 1.6 2010/12/31 20:21:41 jer Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="a dynamic resource editor for X Toolkit applications"

KEYWORDS="amd64 arm hppa ~mips ~ppc ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXmu
	x11-libs/libXaw"
DEPEND="${RDEPEND}"
