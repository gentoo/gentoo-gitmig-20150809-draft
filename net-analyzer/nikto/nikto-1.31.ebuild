# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nikto/nikto-1.31.ebuild,v 1.3 2004/03/14 11:56:29 mcummings Exp $

DESCRIPTION="Web Server vulnerability scanner."
HOMEPAGE="http://www.cirt.net/code/nikto.shtml"
SRC_URI="http://www.cirt.net/source/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
RDEPEND=${DEPEND}
RDEPEND=">=perl-5.6.1
		>=libwhisker-1.5
		>=nmap-3.00
		ssl? ( dev-libs/openssl ) "
IUSE=""

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	einfo ${WORKDIR}
	cd  ${S}
	sed	-i -e 's:config.txt:nikto.conf:' \
		-i -e 's:\$CFG{configfile}="nikto.conf":\$CFG{configfile}="/etc/nikto/nikto.conf":' \
		 nikto.pl
	mv config.txt nikto.conf
	sed -i -e 's:^#NMAP:NMAP:' \
		-i -e 's:^PROXYHOST:#PROXYHOST:' \
		-i -e 's:^PROXYPORT:#PROXYPORT:' \
		-i -e 's:^PROXYUSER:#PROXYUSER:' \
		-i -e 's:^PROXYPASS:#PROXYPASS:' \
		-i -e 's:# PLUGINDIR=/usr/local/nikto/plugins:PLUGINDIR=/usr/share/nikto/plugins:' \
		 nikto.conf
}

src_install() {
	cd ${S}
	insinto /etc/nikto
	doins nikto.conf
	cd docs
	dodoc CHANGES.txt LICENSE.txt README_plugins.txt nikto_usage.txt
	dohtml nikto_usage.html
	cd ..
	dodir /usr/bin
	dobin nikto.pl
	dosym /usr/bin/nikto.pl /usr/bin/nikto
	dodir /usr/share/nikto/plugins
	insinto /usr/share/nikto/plugins
	cd plugins
	doins *
}
