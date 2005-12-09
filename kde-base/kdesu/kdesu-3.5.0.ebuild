# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesu/kdesu-3.5.0.ebuild,v 1.4 2005/12/09 09:22:14 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils flag-o-matic

DESCRIPTION="KDE: gui for su(1)"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

PATCHES="${FILESDIR}/${P}-bindnow.patch"

src_compile() {
	export BINDNOW_FLAGS="$(bindnow-flags)"

	kde-meta_src_compile
}
