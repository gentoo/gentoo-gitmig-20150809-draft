# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-3.5.0.ebuild,v 1.5 2005/12/12 17:31:54 josejx Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils flag-o-matic

DESCRIPTION="KDE: A dialer and front-end to pppd"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

PATCHES="${FILESDIR}/${P}-bindnow.patch"

src_compile() {
	export BINDNOW_FLAGS="$(bindnow-flags)"
	kde-meta_src_compile
}
