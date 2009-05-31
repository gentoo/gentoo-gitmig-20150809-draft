# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmix/kmix-3.5.10.ebuild,v 1.2 2009/05/31 19:40:28 nixnut Exp $

KMNAME=kdemultimedia
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="aRts mixer gui"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="alsa"

DEPEND="alsa? ( media-libs/alsa-lib )"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/kmix-3.5.6-alsa-tests.patch"

src_compile() {
	local myconf="$(use_with alsa)"
	kde-meta_src_compile
}
