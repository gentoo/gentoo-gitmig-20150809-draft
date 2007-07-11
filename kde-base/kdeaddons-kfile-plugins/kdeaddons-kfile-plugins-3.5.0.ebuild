# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-kfile-plugins/kdeaddons-kfile-plugins-3.5.0.ebuild,v 1.21 2007/07/11 01:08:47 mr_bones_ Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kfile-plugins/"
MAXKDEVER=3.5.5
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kdeaddons kfile plugins"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="ssl"
DEPEND="ssl? ( dev-libs/openssl )"

# ssl is needed by kfile-cert, not an hard-dep

src_compile() {
	myconf="$(use_with ssl)"
	kde_src_compile
}
