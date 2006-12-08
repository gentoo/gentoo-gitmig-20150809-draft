# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pmk/pmk-0.8.1-r1.ebuild,v 1.1 2006/12/08 22:25:38 masterdriverz Exp $

DESCRIPTION="Aims to be an alternative to GNU autoconf"
HOMEPAGE="http://pmk.sourceforge.net/"
SRC_URI="mirror://sourceforge/pmk/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=""

src_compile() {
	./pmkcfg.sh -p /usr
	emake || die "Build failed"
}

src_install () {
	emake DESTDIR=${D} MANDIR=/usr/share/man install || die

	dodoc BUGS Changelog INSTALL LICENSE README STATUS TODO
}

pkg_postinst() {
	if [[ ! -f ${ROOT}etc/pmk/pmk.conf ]] ; then
		einfo
		einfo "${ROOT}etc/pmk/pmk.conf doesn't exist."
		einfo "Running pmksetup to generate an initial pmk.conf."
		einfo
		# create one with initial values
		${ROOT}usr/sbin/pmksetup
		# run it again to reset PREFIX from /usr/local to /usr
		${ROOT}usr/sbin/pmksetup -u PREFIX="/usr" &>/dev/null
	fi
}
