# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Maintainer: Thilo Bangert <bangert@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.3 2002/02/04 15:46:51 gbevin Exp

S=${WORKDIR}/${P}

DESCRIPTION="vmailmgr - virtual domains for qmail"
SRC_URI="http://www.vmailmgr.org/current/${P}.tar.gz"
HOMEPAGE="http://www.vmailmgr.org"

DEPEND="virtual/glibc"
RDEPEND=">=sys-apps/ucspi-unix-0.34
	>=net-mail/qmail-1.03-r7
	>=net-mail/qmail-autoresponder-0.95"

src_unpack() {
	unpack ${A} ; cd ${S}

	#make sure stuff get's installed the right places
	mv configure configure.orig
	sed -e "s:^cgidir=.*:cgidir=\"/etc/vmailmgr/cgi-bin\":" \
		-e "s:^phpdir=.*:phpdir=\"/etc/vmailmgr/php\":" \
		configure.orig > configure
	chmod ug+x configure
}

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die

	#add documentation

	exeinto /var/lib/supervise/vmailmgrd
	newexe ${S}/scripts/vmailmgrd.run run

	exeinto /var/lib/supervise/vmailmgrd/log
	newexe ${S}/scripts/vmailmgrd-log.run run

	exeinto /etc/vmailmgr
	newexe ${S}/scripts/autoresponder.sh vdeliver-postdeliver

	doexe ${FILESDIR}/checkvpw-loginfail
	doexe ${FILESDIR}/socket-file
	doexe ${FILESDIR}/separators

}

pkg_postinst() {
	einfo "To start vmailmgrd you need to link"
	einfo "/var/lib/supervise/vmailmgrd to /service"
}
