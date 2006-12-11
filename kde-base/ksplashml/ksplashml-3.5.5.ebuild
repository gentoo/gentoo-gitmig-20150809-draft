# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksplashml/ksplashml-3.5.5.ebuild,v 1.9 2006/12/11 11:59:47 kloeri Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE splashscreen framework (the splashscreen of KDE itself, not of individual apps)"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xinerama"

RDEPEND="xinerama? ( || ( x11-libs/libXinerama <virtual/x11-7 ) )"

DEPEND="${RDEPEND}
	xinerama? ( || ( x11-proto/xineramaproto <virtual/x11-7 ) )"

src_compile() {
	myconf="${myconf} $(use_with xinerama)"

	kde-meta_src_compile
}
