# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/cvsweb/cvsweb-1.93-r1.ebuild,v 1.3 2002/07/14 20:25:23 aliz Exp $

A=${P}.tar.gz
S=${WORKDIR}/cvsweb
DESCRIPTION="WWW interface to a CVS tree"
SRC_URI="http://stud.fh-heilbronn.de/~zeller/download/${A}"
HOMEPAGE="http://stud.fh-heilbronn.de/~zeller/cgi/cvsweg.cgi"
KEYWORDS="x86"
SLOT="0"
LICENSE="BSD"

RDEPEND=">=sys-devel/perl-5 >=app-text/rcs-5.7"

src_unpack () {
	unpack ${A}
	cd ${S}
	local x
	for x in cvsweb.cgi cvsweb.conf
	do
		cp ${x} ${x}.orig
		sed -e "s:/usr/local/web/apache/conf/:/etc/httpd/:" ${x}.orig > ${x}
	done
}

src_install () {
    cd ${S}
    insinto /etc/httpd
    doins cvsweb.conf
    insinto /usr/local/httpd/cgi-bin
    insopts -m755
    doins cvsweb.cgi
    dodoc README TODO
}


