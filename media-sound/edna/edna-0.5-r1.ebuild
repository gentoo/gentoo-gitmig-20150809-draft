# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/edna/edna-0.5-r1.ebuild,v 1.1 2003/12/14 23:17:39 nerdboy Exp $

# This is Greg Stein's streaming audio server

IUSE="python ednad"


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

	if [ "`use ednad`" ]; then
		einfo "Installing in daemon mode"
		insinto /etc/init.d
		insopts -m 755
		newins ${FILESDIR}/edna.gentoo edna
		exeinto /usr/bin ; doexe daemon/ednad
	fi

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
	dosym templates /etc/edna/templates

	dodoc COPYING README ChangeLog
	dohtml -r www/*
}

pkg_postinst() {
	ewarn
	einfo "Edit edna.conf to suite before starting edna and test it."
	einfo "Emerge with USE="ednad" if you want to install in daemon"
	einfo "mode.  See edna.conf and the html docs for more info."
	ewarn
}
