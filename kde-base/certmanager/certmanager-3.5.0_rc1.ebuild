# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/certmanager/certmanager-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:23 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE certificate manager gui"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="
$(deprange 3.5_beta1 $MAXKDEVER kde-base/libkpgp)
$(deprange 3.5_beta1 $MAXKDEVER kde-base/libkdenetwork)"

KMCOPYLIB="libqgpgme libkdenetwork/qgpgme/"
KMEXTRACTONLY="libkdenetwork/
	libkpgp/
	libkdepim/"

KMEXTRA="
	doc/kleopatra
	doc/kwatchgnupg"
