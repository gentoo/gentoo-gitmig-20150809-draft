# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmix/kmix-3.5.9.ebuild,v 1.7 2008/05/18 16:43:57 maekke Exp $

KMNAME=kdemultimedia
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="aRts mixer gui"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="alsa"

DEPEND="alsa? ( media-libs/alsa-lib )"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/kmix-3.5.6-alsa-tests.patch"

src_compile() {
	local myconf="$(use_with alsa)"
	kde-meta_src_compile
}
