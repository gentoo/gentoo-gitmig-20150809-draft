# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcheckpass/kcheckpass-3.5.0.ebuild,v 1.5 2005/12/09 09:27:21 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils flag-o-matic

DESCRIPTION="A simple password checker, used by any software in need of user authentication."
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="pam"
DEPEND="pam? ( kde-base/kdebase-pam ) !pam? ( sys-apps/shadow )"

PATCHES="${FILESDIR}/${P}-bindnow.patch"

src_compile() {
	myconf="$(use_with pam)"

	export BINDNOW_FLAGS="$(bindnow-flags)"
	kde-meta_src_compile
}
