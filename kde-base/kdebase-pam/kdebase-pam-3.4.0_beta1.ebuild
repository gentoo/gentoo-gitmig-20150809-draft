# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-pam/kdebase-pam-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:30 danarmak Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"

DESCRIPTION="KDE pam.d files"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-libs/pam"
LICENSE="GPL-2"
SLOT=3.4

src_install() {
	insinto /etc/pam.d
	newins $FILESDIR/kde.pam kde
	newins $FILESDIR/kde-np.pam kde-np
}
