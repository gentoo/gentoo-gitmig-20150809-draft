# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksayit/ksayit-3.5.9.ebuild,v 1.1 2008/02/20 23:18:51 philantrop Exp $
KMNAME=kdeaccessibility
EAPI="1"
inherit kde-meta

DESCRIPTION="KDE text-to-speech frontend."
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=kde-base/kttsd-${PV}:${SLOT}
	>=kde-base/arts-${PV}:${SLOT}
	>=kde-base/kdemultimedia-arts-${PV}:${SLOT}"

RDEPEND="${DEPEND}"

src_compile() {
	myconf="--enable-ksayit-audio-plugins"
	kde-meta_src_compile
}
