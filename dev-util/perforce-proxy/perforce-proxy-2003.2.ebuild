# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/perforce-proxy/perforce-proxy-2003.2.ebuild,v 1.2 2004/04/26 01:41:51 vapier Exp $

inherit eutils

DESCRIPTION="Proxy daemon for a commercial version control system"
HOMEPAGE="http://www.perforce.com/"
SRC_URI="ftp://ftp.perforce.com/perforce/r03.2/bin.linux24x86/p4p"

LICENSE="perforce.pdf"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="nomirror nostrip"

DEPEND="virtual/glibc"

S=${WORKDIR}

MY_FILES=${FILESDIR}/perforce-proxy-2003.1/

src_unpack() {
	# we have to copy all of the files from $DISTDIR, otherwise we get
	# sandbox violations when trying to install

	for x in p4p ; do
		cp ${DISTDIR}/$x .
	done
}

src_install() {
	enewuser perforce
	enewgroup perforce

	dosbin p4p

	fowners perforce:perforce /usr/sbin/p4p

	mkdir -p ${D}/var/log
	touch ${D}/var/log/perforce-proxy
	fowners perforce:perforce /var/log/perforce-proxy

	keepdir /var/cache/perforce-proxy
	fowners perforce:perforce /var/cache/perforce-proxy

	exeinto /etc/init.d
	doexe ${MY_FILES}/init.d/perforce-proxy
	insinto /etc/conf.d
	doins ${MY_FILES}/conf.d/perforce-proxy
}
