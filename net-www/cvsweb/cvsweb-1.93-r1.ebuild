# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/cvsweb/cvsweb-1.93-r1.ebuild,v 1.14 2004/07/14 06:19:58 mr_bones_ Exp $

DESCRIPTION="WWW interface to a CVS tree"
HOMEPAGE="http://stud.fh-heilbronn.de/~zeller/cgi/cvsweb.cgi"
SRC_URI="http://stud.fh-heilbronn.de/~zeller/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

RDEPEND=">=dev-lang/perl-5
	>=app-text/rcs-5.7"

S="${WORKDIR}/cvsweb"

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
