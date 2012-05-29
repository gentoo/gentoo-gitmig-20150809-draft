# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnssec-tools/dnssec-tools-1.12.2-r1.ebuild,v 1.1 2012/05/29 01:52:29 xmw Exp $

EAPI=4

inherit qt4-r2

DESCRIPTION="tools to ease the deployment of DNSSEC related technologies"
HOMEPAGE="http://www.dnssec-tools.org/"
SRC_URI="http://www.dnssec-tools.org/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 static-libs threads"

RDEPEND="dev-lang/perl
	dev-libs/openssl
	dev-perl/Getopt-GUI-Long
	dev-perl/GraphViz
	dev-perl/MailTools
	dev-perl/Net-DNS
	dev-perl/XML-Simple"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -e '/^maninstall:/,+3s:$(MKPATH) $(mandir)/$(man1dir):$(MKPATH) $(DESTDIR)/$(mandir)/$(man1dir):' \
		-i Makefile.in || die

	rm -r validator/apps/{dnssec-{check,nodes,system-tray},lookup}
}

src_configure() {
	econf \
		--disable-bind-checks \
		--with-dlv \
		--with-nsec3 \
		--with-gnu-ld \
		--with-validator \
		$(use_with ipv6) \
		$(use_enable static-libs static) \
		$(use_with threads)
}

src_compile() {
	my_prognames="VALIDATOR=dnssec-validate
		GETHOST=dnssec-gethost
		GETADDR=dnssec-getaddr
		GETRRSET=dnssec-getrrset
		GETQUERY=dnssec-getquery
		GETNAME=dnssec-getname
		CHECK_CONF=dnssec-libval_check_conf
		SRES_TEST=dnssec-libsres_test"
	emake $my_prognames
}

src_install() {
	emake DESTDIR="${D}" $my_prognames install
	if ! use static-libs ; then
		find "${D}" -name "*.la" -delete || die
	fi
}

pkg_postinst() {
	einfo
	elog "Please run 'dtinitconf' in order to set up the required"
	elog "/etc/dnssec-tools/dnssec-tools.conf file"
	einfo
}
