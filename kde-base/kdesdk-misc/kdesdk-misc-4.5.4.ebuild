# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-misc/kdesdk-misc-4.5.4.ebuild,v 1.3 2010/12/04 15:32:35 mr_bones_ Exp $

EAPI="3"

KMNAME="kdesdk"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="KDE miscellaneous SDK tools"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug extras"

RDEPEND="
	extras? ( >=dev-java/antlr-2.7.7:0[cxx,script] )
"
DEPEND="${RDEPEND}
	!!<${CATEGORY}/${P}
"

# see bug 332319, let's find out how well portage handles this - dilfridge
# summary for maintainers:
# at build time an earlier installed version causes the build to fail.
# we cannot use add_blocker since we need a *hard* blocker in *DEPEND*
# nobody knows what happens with kdeprefix, but probably also nobody cares.

KMEXTRA="
	doc/kmtrace/
	doc/poxml/
	kmtrace/
	kpartloader/
	kprofilemethod/
	kspy/
	kunittest/
	poxml/
	scheck/
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with extras Antlr2)
	)

	kde4-meta_src_configure
}
