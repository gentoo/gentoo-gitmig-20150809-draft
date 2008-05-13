# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knetworkconf/knetworkconf-3.5.9.ebuild,v 1.4 2008/05/13 00:22:36 jer Exp $

KMNAME=kdeadmin

EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE network configuration manager"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
DEPEND=""

src_unpack() {
	kde-meta_src_unpack

	sed -i -e "/Categories/s:Configuration-KDE-Network-mdk:X-\&:" \
		knetworkconf/knetworkconf/kcm_knetworkconfmodule.desktop || die "sed failed"
}
