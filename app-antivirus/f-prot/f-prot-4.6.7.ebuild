# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/f-prot/f-prot-4.6.7.ebuild,v 1.1 2006/12/10 09:27:04 ticho Exp $

inherit eutils

IUSE=""

MY_P="fp-linux-ws-${PV}"
S=${WORKDIR}/${PN}

DESCRIPTION="Frisk Software's f-prot virus scanner"
HOMEPAGE="http://www.f-prot.com/"
SRC_URI="ftp://ftp.f-prot.com/pub/linux/${MY_P}.tar.gz"
DEPEND=""
# unzip and perl are needed for the check-updates.pl script
RDEPEND=">=app-arch/unzip-5.42-r1
	dev-lang/perl
	dev-perl/libwww-perl
	amd64? ( >=app-emulation/emul-linux-x86-baselibs-1.0 )"
PROVIDE="virtual/antivirus"

SLOT="0"
LICENSE="F-PROT"
KEYWORDS="~amd64 -ppc -sparc ~x86"

src_install() {
	cd ${S}

	dobin ${FILESDIR}/f-prot.sh
	dosym /usr/bin/f-prot.sh /usr/bin/f-prot

	dodir /opt/f-prot/tools /var/tmp/f-prot
	keepdir /var/tmp/f-prot

	insinto /opt/f-prot
	insopts -m 755

	newins etc/f-prot.conf.default f-prot.conf
	dodir /etc
	dosym /opt/f-prot/f-prot.conf /etc/f-prot.conf

	doins f-prot
	insopts -m 755
	doins *.DEF ENGLISH.TX0

	doman man_pages/*
	dodoc LICENSE* CHANGES README
	dohtml doc_ws/*

	insinto /opt/f-prot/tools
	insopts -m 755
	doins tools/check-updates.pl
}

pkg_postinst() {
	echo
	einfo "Remember to run /opt/f-prot/tools/check-updates.pl regularly to keep virus"
	einfo "database up to date. Recommended method is to use cron. See manpages for"
	einfo "cron(8) and crontab(5) for more info."
	einfo "An example crontab entry, causing check-updates.pl to run every night at 4AM:"
	echo
	echo "0 4 * * * /opt/f-prot/tools/check-updates.pl >/dev/null"
	echo
	einfo "For more examples, see /usr/share/doc/${PF}/html/auto_updt.html"
	echo
}
