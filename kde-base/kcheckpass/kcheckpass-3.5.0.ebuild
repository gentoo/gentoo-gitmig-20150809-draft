# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcheckpass/kcheckpass-3.5.0.ebuild,v 1.3 2005/12/01 12:53:56 flameeyes Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="A simple password checker, used by any software in need of user authentication."
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="pam"
DEPEND="pam? ( kde-base/kdebase-pam ) !pam? ( sys-apps/shadow )"

src_compile() {
	myconf="$(use_with pam)"
	kde-meta_src_compile
}
