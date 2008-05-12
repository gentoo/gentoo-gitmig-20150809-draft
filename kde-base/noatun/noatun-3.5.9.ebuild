# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/noatun/noatun-3.5.9.ebuild,v 1.5 2008/05/12 22:46:29 jer Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
EAPI="1"
inherit kde-meta eutils flag-o-matic

DESCRIPTION="A modular media player for KDE, featuring audio effects, graphic equalizer and network transparency."
KEYWORDS="alpha ~amd64 hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=kde-base/kdemultimedia-arts-${PV}:${SLOT}"

KMCOMPILEONLY="arts"

src_compile() {
	# fix bug 128884
	filter-flags -fomit-frame-pointer
	kde-meta_src_compile
}
