# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vmailmgr/vmailmgr-0.96.9-r1.ebuild,v 1.5 2002/07/17 05:26:37 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="vmailmgr - virtual domains for qmail"
SRC_URI="http://www.vmailmgr.org/current/${P}.tar.gz"
HOMEPAGE="http://www.vmailmgr.org"

DEPEND="virtual/glibc"
RDEPEND=">=sys-apps/ucspi-unix-0.34
	>=net-mail/qmail-1.03-r7
	>=net-mail/qmail-autoresponder-0.95"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A} ; cd ${S}

	#make sure stuff get's installed the right places
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff || die

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

	dodoc AUTHORS INSTALL README TODO NEWS

	exeinto /var/lib/supervise/vmailmgrd
	newexe ${S}/scripts/vmailmgrd.run run

	exeinto /var/lib/supervise/vmailmgrd/log
	newexe ${S}/scripts/vmailmgrd-log.run run

	exeinto /etc/vmailmgr
	newexe ${S}/scripts/autoresponder.sh vdeliver-postdeliver

	doexe ${FILESDIR}/checkvpw-loginfail
	
	insinto /etc/vmailmgr
	doins ${FILESDIR}/socket-file
	doins ${FILESDIR}/separators

}

pkg_postinst() {
	einfo "To start vmailmgrd you need to link"
	einfo "/var/lib/supervise/vmailmgrd to /service"
}
