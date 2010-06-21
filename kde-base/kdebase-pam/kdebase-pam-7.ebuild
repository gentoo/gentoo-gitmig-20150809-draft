# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-pam/kdebase-pam-7.ebuild,v 1.12 2010/06/21 16:03:42 scarabeus Exp $

inherit pam

DESCRIPTION="pam.d files used by several KDE components."
HOMEPAGE="http://www.kde.org"
LICENSE="as-is"

SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/pam"
RDEPEND="${DEPEND}"

src_install() {
	newpamd "${FILESDIR}/kde.pam-${PV}" kde
	newpamd "${FILESDIR}/kde-np.pam-6" kde-np
}
