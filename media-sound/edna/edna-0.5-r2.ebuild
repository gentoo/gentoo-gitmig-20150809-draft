# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/edna/edna-0.5-r2.ebuild,v 1.1 2003/12/15 00:36:43 nerdboy Exp $

# This is Greg Stein's streaming audio server

IUSE="python"


DESCRIPTION="Greg Stein's python streaming audio server for desktop or LAN use"
HOMEPAGE="http://edna.sourceforge.net/"
#SRC_URI="http://edna.sourceforge.net/${P}.tar.gz"
SRC_URI="mirror://sourceforge/edna/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND="dev-lang/python"

RDEPEND="${DEPEND}"

src_install() {

	einfo "Installing in daemon mode"
	insinto /etc/init.d
	insopts -m 755
	newins ${FILESDIR}/edna.gentoo edna

	dodir /usr/bin /usr/lib/edna /usr/lib/edna/templates
	exeinto /usr/bin ; newexe edna.py edna
	exeinto /usr/lib/edna ; doexe ezt.py
	exeinto /usr/lib/edna ; doexe MP3Info.py
	insinto /usr/lib/edna/templates
	insopts -m 644
	doins templates/*

	insinto /etc/edna
	insopts -m 644
	doins edna.conf
	dosym /usr/lib/edna/templates /etc/edna/templates

	dodoc COPYING README ChangeLog
	dohtml -r www/*

	dodir /etc/env.d
	echo "PYTHONPATH=/usr/lib/edna" > ${D}/etc/env.d/69edna
}

pkg_postinst() {
	ewarn
	einfo "Edit edna.conf to suite before starting; test ednad from"
	einfo "a shell prompt until you have it configured properly,"
	einfo "then add edna to the default runlevel when you're ready."
	einfo "See edna.conf and the html docs for more info."
	ewarn
}
