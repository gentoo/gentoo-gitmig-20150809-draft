# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/artsplugin-akode/artsplugin-akode-3.5.9.ebuild,v 1.3 2008/05/12 15:33:51 armin76 Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=akode_artsplugin
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="aKode aRts plugin."
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/akode
	>=kde-base/kdemultimedia-arts-${PV}:${SLOT}"
DEPEND="${RDEPEND}"

KMCOPYLIB="libartsbuilder arts/runtime"

src_compile() {
	local myconf="--with-akode"

	kde-meta_src_compile
}
