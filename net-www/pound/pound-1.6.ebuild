# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/pound/pound-1.6.ebuild,v 1.1 2004/01/27 19:12:41 mholzer Exp $

MY_P=${P/p/P}

DESCRIPTION="A http/https reverse-proxy and load-balancer."
SRC_URI="http://www.apsis.ch/pound/${MY_P}.tgz"
HOMEPAGE="http://www.apsis.ch/pound/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hppa"
IUSE="ssl"

DEPEND="virtual/glibc
	ssl? ( dev-libs/openssl )"

S=${WORKDIR}/${MY_P}

src_compile() {
	local myconf

	## check for ssl-support:
	if [ "$(use ssl)" ]; then
		myconf="${myconf} --with-ssl"
	else
		myconf="${myconf} --without-ssl"
	fi

	## TODO: how to handle the missing "syslog" USE-flag?
	## check for syslog-support:
	#if [ "$(use syslog)" ]; then
	#	myconf="${myconf} --with-log="
	#else
	#	myconf="${myconf} --without-log"
	#fi

	econf ${myconf} || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	dosbin pound
	doman pound.8

	dodoc README

	exeinto /etc/init.d
	newexe ${FILESDIR}/pound.init pound

	insinto /etc
	doins ${FILESDIR}/pound.cfg
}

pkg_postinst() {
	einfo "No demo-/sample-configfile is included in the distribution -- read the man-page"
	einfo "for more info."
	einfo "A sample (localhost:8888 -> localhost:80) for gentoo is given in \"/etc/pound.cfg\"."
}
