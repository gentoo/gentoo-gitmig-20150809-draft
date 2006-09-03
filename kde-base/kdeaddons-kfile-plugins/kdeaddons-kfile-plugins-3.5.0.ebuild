# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-kfile-plugins/kdeaddons-kfile-plugins-3.5.0.ebuild,v 1.18 2006/09/03 12:15:17 kloeri Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kfile-plugins/"
MAXKDEVER=3.5.4
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kdeaddons kfile plugins"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="ssl"
DEPEND="ssl? ( dev-libs/openssl )"

# ssl is needed by kfile-cert, not an hard-dep

src_compile() {
	myconf="$(use_with ssl)"
	kde_src_compile
}

