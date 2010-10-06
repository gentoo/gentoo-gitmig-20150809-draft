# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-scripts/kdesdk-scripts-4.5.2.ebuild,v 1.1 2010/10/06 09:17:20 alexxy Exp $

EAPI="3"

KDE_HANDBOOK="optional"
KMNAME="kdesdk"
KMMODULE="scripts"
inherit kde4-meta

DESCRIPTION="KDE SDK Scripts"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+handbook debug"

src_prepare() {
	# bug 275069
	sed -ie 's:colorsvn::' scripts/CMakeLists.txt || die

	kde4-meta_src_prepare
}
