# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tcb/tcb-0.9.8.7.ebuild,v 1.1 2004/01/08 22:41:43 method Exp $

inherit eutils

S=${WORKDIR}/${P}

DESCRIPTION="Libraries and tools implementing the tcb password shadowing scheme."
SRC_URI="ftp://ftp.openwall.com/pub/projects/tcb/${P}.tar.gz"
HOMEPAGE="http://www.openwall.com"
LICENSE="GPL-2"

DEPEND=">=sys-libs/pam-0.75"
SLOT="0"
KEYWORDS="x86 amd64"

pkg_setup() {
	# might want to add these into baselayout eventually...
	for group in auth chkpwd shadow; do
			 enewgroup ${group} || die "error adding group ${group}"
	done
}

src_compile () {
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog LICENSE

	einfo "You must now run /sbin/tcb_convert to convert your shadow to tcb"
	einfo "To remove this you must first run /sbin/tcp_unconvert and then unmerge"
}
