# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tcb/tcb-0.9.7.4.ebuild,v 1.6 2003/06/21 21:19:41 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Libraries and tools implementing the tcb password shadowing scheme."
# This is a bad solution, but the original source archive is in the Owl cvs
SRC_URI="http://www.SuxOS.org/~styx/gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.openwall.com"
LICENSE="GPL-2"

DEPEND=">=sys-libs/pam-0.75"
SLOT="0"
KEYWORDS="x86 amd64"

pkg_preinst() {
	# might want to add these into baselayout eventually...
	for group in auth chkpwd shadow; do
		if ! grep -q ^${group}: /etc/group ; then
			 groupadd ${group} || die "problem adding group $group"
		fi
	done
}

src_compile() {
#	cd ${WORKDIR}
	emake || die
}

src_install () {
	make FAKEROOT=${D} install || die
	dodoc ChangeLog LICENSE
}
