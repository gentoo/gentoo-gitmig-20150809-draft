# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gentoo-stats/gentoo-stats-0.1.ebuild,v 1.4 2002/08/25 22:38:15 gerk Exp $

DESCRIPTION="Gentoo usage statistics client daemon"
HOMEPAGE="http://gentoo.iq-computing.de"
SRC_URI="http://gentoo.iq-computing.de/client/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc sparc sparc64"

RDEPEND=">=sys-devel/perl-5.6.1
	dev-perl/libwww-perl"
DEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	echo "nothing to compile"
}

src_install () {
	into /usr
	dosbin gentoo-stats
}

pkg_postinst() {
	einfo 'You must run "gentoo-stats --new" to obtain a system ID.'
	einfo "After that, create a new cronjob that looks like this:"
	einfo ""
	einfo "\t0 0 * * 0,4 /usr/sbin/gentoo-stats --update <your system ID>"
}
