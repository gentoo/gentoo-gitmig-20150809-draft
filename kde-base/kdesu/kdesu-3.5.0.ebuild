# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesu/kdesu-3.5.0.ebuild,v 1.16 2006/05/30 05:09:43 josejx Exp $

KMNAME=kdebase
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils flag-o-matic

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-${PV}-patches-1.tar.bz2"

DESCRIPTION="KDE: gui for su(1)"
KEYWORDS="~alpha amd64 ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

src_unpack() {
	unpack "kdebase-${PV}-patches-1.tar.bz2"
	kde-meta_src_unpack

	epatch "${WORKDIR}/patches/${P}-bindnow.patch"
}

src_compile() {
	export BINDNOW_FLAGS="$(bindnow-flags)"

	kde-meta_src_compile
}
