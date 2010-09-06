# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-scripts/kdesdk-scripts-4.5.1.ebuild,v 1.1 2010/09/06 00:16:25 tampakrap Exp $

EAPI="3"

KDE_HANDBOOK=1
KMNAME="${PN/-*/}"
KMMODULE="${PN/*-/}"

inherit kde4-meta

DESCRIPTION="KDE SDK Scripts"
KEYWORDS=""
IUSE="+handbook debug"

src_prepare() {
	# bug 275069
	sed -ie 's:colorsvn::' scripts/CMakeLists.txt || die

	kde4-meta_src_prepare
}
