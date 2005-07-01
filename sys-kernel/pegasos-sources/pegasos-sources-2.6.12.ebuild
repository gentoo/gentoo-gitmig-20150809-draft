# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/pegasos-sources/pegasos-sources-2.6.12.ebuild,v 1.1 2005/07/01 15:06:34 dholm Exp $

DESCRIPTION="Stub ebuild informing users of the move to gentoo-sources"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="${PVR}"
KEYWORDS="~ppc"
DEPEND=">=sys-kernel/gentoo-sources-2.6.12"

pkg_postinst() {
	einfo "Since support for all the hardware in the Pegasos has been added"
	einfo "to 2.6.12 vanilla, pegasos-sources will be removed shortly."
	einfo "This is just a stub ebuild that installs >=gentoo-sources-2.6.12,"
	einfo "which is the kernel we recommend that you use."
}
