# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/ssmtp/ssmtp-2.38.14-r1.ebuild,v 1.8 2002/07/16 04:54:33 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Extremely simple MTA to get mail off the system to a Mailhub"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/system/mail/mta/${P}.tar.gz"

DEPEND="virtual/glibc"
RDEPEND="!virtual/mta net-mail/mailbase"
PROVIDE="virtual/mta"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_compile() {						   
   make clean || die
   make ${MAKEOPTS} || die
}

src_install() {							   
	dodir /usr/bin /usr/sbin /usr/lib
	dosbin ssmtp
	chmod 755 ${D}/usr/sbin/ssmtp
	dosym /usr/sbin/ssmtp /usr/bin/mailq
	dosym /usr/sbin/ssmtp /usr/bin/newaliases
	dosym /usr/sbin/ssmtp /usr/bin/mail
	dosym /usr/sbin/ssmtp /usr/sbin/sendmail
	dosym /usr/sbin/ssmtp /usr/lib/sendmail
	doman ssmtp.8
	dosym /usr/share/man/man8/ssmtp.8 /usr/share/man/man8/sendmail.8
	dodoc CHANGELOG INSTALL MANIFEST README
	newdoc ssmtp.lsm DESC
	insinto /etc/ssmtp
	doins ssmtp.conf revaliases
}

pkg_config() {

	conffile="/etc/ssmtp/ssmtp.conf"
	hostname=`hostname -f`
	domainame=`hostname -d`
	mv ${conffile} ${conffile}.orig
	sed -e "s:rewriteDomain\=:rewriteDomain\=${domainame}:g" \
		-e "s:_HOSTNAME_:${hostname}:" \
		-e "s:\=mail:\=mail.${domainame}:g" \
		${conffile}.orig > ${conffile}

}
