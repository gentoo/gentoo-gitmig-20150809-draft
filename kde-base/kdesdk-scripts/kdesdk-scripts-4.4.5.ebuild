# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-scripts/kdesdk-scripts-4.4.5.ebuild,v 1.6 2010/09/15 08:12:07 reavertm Exp $

EAPI="3"

KMNAME="kdesdk"
KMMODULE="scripts"
inherit kde4-meta

DESCRIPTION="KDE SDK Scripts"
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="+handbook debug"

src_prepare() {
	# bug 275069
	sed -ie 's:colorsvn::' scripts/CMakeLists.txt || die

	kde4-meta_src_prepare
}
