# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/cvsweb/cvsweb-1.112.ebuild,v 1.10 2003/09/06 01:54:08 msterret Exp $

SLOT="0"
KEYWORDS="x86 sparc ~ppc"
LICENSE="BSD"
DESCRIPTION="WWW interface to a CVS tree"
SRC_URI="http://stud.fh-heilbronn.de/~zeller/download/${P}.tar.gz"
HOMEPAGE="http://stud.fh-heilbronn.de/~zeller/cgi/cvsweb.cgi"

S="${WORKDIR}/cvsweb"
RDEPEND=">=dev-lang/perl-5 >=app-text/rcs-5.7"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	local x
	for x in cvsweb.cgi cvsweb.conf
	do
		cp ${x} ${x}.orig
		sed -e "s:/usr/local/web/apache/conf/:/etc/apache/conf/:g" ${x}.orig > ${x}
	done
}

src_install() {
	cd ${S}
	insinto /etc/apache/conf
	doins cvsweb.conf
	insinto /home/httpd/cgi-bin
	insopts -m755
	doins cvsweb.cgi
	dodoc README TODO
}
