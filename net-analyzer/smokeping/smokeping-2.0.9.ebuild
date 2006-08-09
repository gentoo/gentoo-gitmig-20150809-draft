# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/smokeping/smokeping-2.0.9.ebuild,v 1.1 2006/08/09 18:09:00 chtekk Exp $

inherit perl-module eutils

KEYWORDS="~x86 ~amd64"

DESCRIPTION="A powerful latency measurement tool."
SRC_URI="http://people.ee.ethz.ch/~oetiker/webtools/smokeping/pub/${P}.tar.gz"
HOMEPAGE="http://people.ee.ethz.ch/~oetiker/webtools/smokeping/"
LICENSE="GPL-2"
SLOT="0"
IUSE="apache2"

DEPEND="dev-lang/perl
		perl-core/libnet
		>=net-analyzer/rrdtool-1.2
		net-analyzer/fping
		apache2? ( >=net-www/apache-2.0.54-r30 >=www-apache/mod_perl-2.0.1 )"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup smokeping
	enewuser smokeping -1 -1 /var/lib/smokeping smokeping
}

src_compile() {
	# There is a makefile we don't want to run so leave this here
	einfo "Skip compile."
}

src_install() {
	# First move all the perl modules into the vendor lib area of Perl
	perlinfo
	insinto ${VENDOR_LIB}
	doins lib/*.pm
	### This one kind of concerns me, possible conflict with other software
	insinto ${VENDOR_LIB}/Config
	doins lib/Config/*.pm
	insinto ${VENDOR_LIB}/Smokeping
	doins lib/Smokeping/*.pm
	insinto ${VENDOR_LIB}/Smokeping/matchers
	doins lib/Smokeping/matchers/*.pm
	insinto ${VENDOR_LIB}/Smokeping/probes
	doins lib/Smokeping/probes/*.pm

	# Create the files in var for rrd file storage and the cgi webserver script
	keepdir /var/lib/${PN}/.simg
	fowners smokeping:smokeping /var/lib/${PN}
	if use apache2 ; then
		fowners apache:apache /var/lib/${PN}/.simg
	else
		fowners smokeping:smokeping /var/lib/${PN}/.simg
	fi
	fperms 775 /var/lib/${PN} /var/lib/${PN}/.simg
	exeinto /var/www/localhost/perl
	newexe htdocs/${PN}.cgi.dist ${PN}.pl
	dosed 's:^use lib:#use lib:g' /var/www/localhost/perl/${PN}.pl
	dosed 's:sepp/bin/speedy:bin/perl:' /var/www/localhost/perl/${PN}.pl
	dosed 's:/home/oetiker/data/projects/AADJ-smokeping/dist/etc/config:/etc/smokeping:' \
		/var/www/localhost/perl/${PN}.pl

	# Create the binary
	newbin bin/${PN}.dist ${PN}
	dosed 's:/usr/sepp/bin/perl-5.8.4:/usr/bin/perl:g' /usr/bin/${PN}
	dosed 's:^use lib:#use lib:g' /usr/bin/${PN}
	# dosed 's:/sepp::' /usr/bin/${PN}
	dosed 's:etc/config.dist:/etc/smokeping:' /usr/bin/${PN}

	# Create the config files
	insinto /etc
	newins "${FILESDIR}/config.dist" ${PN}
	newins etc/basepage.html.dist ${PN}.template
	doins etc/smokemail.dist
	exeinto /etc/init.d
	newexe "${FILESDIR}/${PN}.init" ${PN}
	if use apache2 ; then
		insinto /etc/apache2/modules.d
		doins "${FILESDIR}/78_${PN}.conf"
	fi
}

pkg_postinst() {
	chown smokeping:smokeping "${ROOT}/var/lib/${PN}"
	chmod 755 "${ROOT}/var/lib/${PN}"
	einfo
	einfo "Four more steps are needed to get ${PN} un&running:"
	einfo "1) You need to edit /etc/${PN}"
	einfo "2) You need to edit the template at /etc/${PN}.template"
	einfo "3) You need to make the fping binary setuid root:"
	einfo "    # chmod 4755 /usr/sbin/fping"
	if use apache2 ; then
		einfo "4) Make sure to add -D PERL to APACHE2_OPTS in /etc/conf.d/apache2"
		einfo "   and to restart apache2."
	fi
	einfo "You can now start ${PN} with '/etc/init.d/${PN} start'."
	einfo
}
