# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/ax25-apps/ax25-apps-0.0.6.ebuild,v 1.1 2003/06/19 19:11:42 rphillips Exp $

DESCRIPTION="Basic AX.25 (Amateur Radio) user tools, additional daemons"
HOMEPAGE="http://ax25.sourceforge.net/"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/ax25/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
        >=dev-libs/libax25-0.0.7"

src_compile() {
	econf || die
	emake || die
}

src_install() {
    make DESTDIR=${D} install || die
    # "installconf" installs sample configurations
    # Gentoo's configuration protection system can work with this
    make DESTDIR=${D} installconf || die

    exeinto /etc/init.d ; newexe ${FILESDIR}/ax25ipd.rc ax25ipd
    newexe ${FILESDIR}/ax25mond.rc ax25mond
    newexe ${FILESDIR}/ax25rtd.rc ax25rtd

    # FIXME: Configuration protect logic for the ax25rtd cache
    #   or move these files
    # Moving might require changes to ax25rtd/ax25rtctl
    insinto /var/lib/ax25/ax25rtd
    newins ${FILESDIR}/ax25rtd.blank ax25_route
    newins ${FILESDIR}/ax25rtd.blank ip_route
}
