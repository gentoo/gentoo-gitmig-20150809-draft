# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/coda-server/coda-server-6.0.3.ebuild,v 1.1 2004/09/09 18:14:24 griffon26 Exp $

IUSE=""

DESCRIPTION="Coda is an advanced networked filesystem developed at Carnegie Mellon Univ."
HOMEPAGE="http://www.coda.cs.cmu.edu"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

# To help people upgrade from coda-server to coda ebuilds, coda is listed as a dependency
# It is installed after this ebuild to give the user a chance to cancel the merge and
# merge the coda ebuild directly.
PDEPEND=">=net-fs/coda-${PV}"

S=${WORKDIR}

pkg_setup() {
	ewarn
	ewarn "This ebuild has been superseded by the coda ebuild."
	ewarn
	ewarn "Please perform the following steps:"
	ewarn "1) cancel this merge by pressing ctrl-C"
	ewarn "2) unmerge coda-server if it is installed (emerge -C coda-server)"
	ewarn "3) merge coda instead (emerge coda)"
	ewarn

	# Give the user time to cancel this merge.
	for TICKER in 1 2 3 4 5 6 7 8 9 10; do
		# Double beep here.
		echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
		echo -ne "\a" ; sleep 1
	done
	sleep 5
}

