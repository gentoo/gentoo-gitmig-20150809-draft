# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fwlogwatch/fwlogwatch-0.9.2.ebuild,v 1.1 2003/06/20 23:34:54 brad Exp $

DESCRIPTION="A packet filter and firewall log analyzer"
HOMEPAGE="http://cert.uni-stuttgart.de/projects/fwlogwatch/"
SRC_URI="http://www.kyb.uni-stuttgart.de/boris/sw/${P}.tar.gz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""
DEPEND=""
RDEPEND=""

src_compile() {
	sed -e "s/^CFLAGS = /CFLAGS = ${CFLAGS} /g" Makefile > ${T}/Makefile.fwlogwatch
	mv -f ${T}/Makefile.fwlogwatch Makefile
	emake || die 
}

src_install() {
	dosbin fwlogwatch
	dosbin contrib/fwlw_notify
	dosbin contrib/fwlw_respond
	dodir /usr/share/fwlogwatch/contrib
	insinto /usr/share/fwlogwatch/contrib
	doins contrib/fwlogsummary.cgi
	doins contrib/fwlogsummary_small.cgi
	doins contrib/fwlogwatch.php
	doins contrib
	insinto /etc
	doins fwlogwatch.config fwlogwatch.template 
	dodoc AUTHORS ChangeLog CREDITS COPYING README
	doman fwlogwatch.8
}
