# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksplashml/ksplashml-3.5.9.ebuild,v 1.7 2008/05/18 15:14:23 maekke Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE splashscreen framework (the splashscreen of KDE itself, not of individual apps)"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xinerama"

RDEPEND="xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	xinerama? ( x11-proto/xineramaproto )"

src_compile() {
	myconf="${myconf} $(use_with xinerama)"

	kde-meta_src_compile
}
