# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/restartd/restartd-0.1_alpha3.ebuild,v 1.1 2005/10/14 04:34:05 vapier Exp $

inherit eutils

MY_PV=${PV/_alpha/.a-}
DESCRIPTION="A daemon for checking your running and not running processes"
HOMEPAGE="http://packages.debian.org/unstable/utils/restartd"
SRC_URI="mirror://debian/pool/main/r/restartd/${PN}_${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}-${PV/_alpha*/.a}

fsrc_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/restartd-0.1-gentoo.diff
}

src_compile() {
	emake C_ARGS="${CFLAGS}" || die
}

src_install() {
	dodir /etc /usr/sbin /usr/share/man/man8
	make install DESTDIR="${D}" || die
}
