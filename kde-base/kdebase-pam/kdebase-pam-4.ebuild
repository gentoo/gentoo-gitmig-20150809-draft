# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-pam/kdebase-pam-4.ebuild,v 1.4 2005/03/24 23:38:11 greg_g Exp $

DESCRIPTION="pam.d files used by several kdebase-derived packages"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE=""

DEPEND="sys-libs/pam"

src_install() {
	insinto /etc/pam.d
	newins "${FILESDIR}"/kde.pam kde
	newins "${FILESDIR}"/kde-np.pam kde-np
}
