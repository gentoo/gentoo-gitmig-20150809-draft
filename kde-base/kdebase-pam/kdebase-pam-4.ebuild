# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-pam/kdebase-pam-4.ebuild,v 1.2 2005/02/07 19:54:50 greg_g Exp $

DESCRIPTION="pam.d files used by several kdebase-derived packages"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86 ~alpha"
IUSE=""
DEPEND="sys-libs/pam"
LICENSE="GPL-2"
SLOT=0

src_install() {
	insinto /etc/pam.d
	newins $FILESDIR/kde.pam kde
	newins $FILESDIR/kde-np.pam kde-np
}
