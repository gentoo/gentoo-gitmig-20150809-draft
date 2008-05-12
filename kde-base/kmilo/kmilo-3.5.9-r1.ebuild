# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmilo/kmilo-3.5.9-r1.ebuild,v 1.3 2008/05/12 20:02:33 ranger Exp $

KMNAME=kdeutils
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="kded module that can support various types of hardware input devices, such as those on keyboards."
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility pbbuttonsd"

DEPEND="pbbuttonsd? ( app-laptop/pbbuttonsd )"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-fixpaths.patch" )

src_compile() {
	local myconf="$(use_with pbbuttonsd powerbook)"

	kde-meta_src_compile
}
