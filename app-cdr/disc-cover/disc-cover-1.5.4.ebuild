# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/disc-cover/disc-cover-1.5.4.ebuild,v 1.3 2004/05/17 15:17:17 usata Exp $

DESCRIPTION="Creates CD-Covers via Latex by fetching cd-info from freedb.org or local file"
HOMEPAGE="http://www.cwi.nl/~jvhemert/disc-cover.html"
SRC_URI="http://www.cwi.nl/~jvhemert/files/${P}.tar.gz"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"
SLOT="0"

DEPEND="dev-lang/perl
	>=sys-apps/sed-4"

RDEPEND="dev-lang/perl
	>=dev-perl/Audio-CD-disc-cover-0.05
	virtual/tetex"

src_compile() {
	sed -i -e "s#/usr/share/disc-cover/#/etc/webapps/${PF}/#" disc-cover
	pod2man disc-cover > disc-cover.1 || die
}

src_install() {
	dobin disc-cover
	doman disc-cover.1

	dodoc AUTHORS CHANGELOG COPYING TODO

	exeinto /usr/share/webapps/${PF}/cgi-bin/
	doexe index.cgi online.cgi

	insinto /usr/share/webapps/${PF}/htdocs/
	doins busy.png offline.png online.png

	insinto /etc/webapps/${PF}/templates
	doins templates/*
}
