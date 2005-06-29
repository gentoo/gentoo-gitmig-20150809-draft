# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/twiki/twiki-20041030.ebuild,v 1.2 2005/06/29 20:02:40 rl03 Exp $

inherit webapp eutils

DESCRIPTION="A Web Based Collaboration Platform"
HOMEPAGE="http://twiki.org/"
SRC_URI="http://ftp.ale.org/pub/mirrors/openpkg/sources/DST/${PN}//TWiki${PV}beta.zip"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S=${WORKDIR}

RDEPEND=">=dev-lang/perl-5.6.2
		perl-core/CGI
		dev-perl/libnet
		>=app-text/rcs-5.7
		sys-apps/diffutils
		virtual/cron
		=net-www/apache-1*"
# apache2 is not supported, see twiki documentation

src_unpack() {
	unpack ${A}
	cd ${S}/lib/TWiki
	epatch ${FILESDIR}/execwithsearch.patch
	# change web user to apache
	find . -name '*,v' -exec sed -i 's|nobody:|apache:|g' '{}' ';'
}

src_compile() {
	:;
}

src_install() {
	webapp_src_preinst

	cp -r . ${D}/${MY_HTDOCSDIR}

	dodoc readme.txt license.txt

	dodir /etc/apache/vhosts.d
	insinto /etc/apache/vhosts.d
	doins ${FILESDIR}/twiki.conf

	chmod 0755 ${D}/${MY_HTDOCSDIR}/bin/*
	for file in `find data pub`; do
		webapp_serverowned "${MY_HTDOCSDIR}/${file}"
	done

	webapp_hook_script ${FILESDIR}/reconfig
	webapp_configfile ${MY_HTDOCSDIR}/bin/setlib.cfg
	webapp_configfile ${MY_HTDOCSDIR}/lib/TWiki.cfg
	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
