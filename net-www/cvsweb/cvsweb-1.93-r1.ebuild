# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/cvsweb/cvsweb-1.93-r1.ebuild,v 1.12 2003/09/08 08:20:44 vapier Exp $

DESCRIPTION="WWW interface to a CVS tree"
HOMEPAGE="http://stud.fh-heilbronn.de/~zeller/cgi/cvsweb.cgi"
SRC_URI="http://stud.fh-heilbronn.de/~zeller/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc"

RDEPEND=">=dev-lang/perl-5 >=app-text/rcs-5.7"

S=${WORKDIR}/cvsweb

src_unpack () {
	unpack ${A}
	cd ${S}
	sed -i "s:/usr/local/web/apache/conf/:/etc/httpd/:" cvsweb.cgi cvsweb.conf
}

src_install() {
	insinto /etc/httpd
	doins cvsweb.conf
	exeinto /usr/httpd/cgi-bin
	doexe cvsweb.cgi
	dodoc README TODO
}
