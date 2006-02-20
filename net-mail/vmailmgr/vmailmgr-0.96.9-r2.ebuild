# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vmailmgr/vmailmgr-0.96.9-r2.ebuild,v 1.4 2006/02/20 22:06:33 hansmi Exp $

inherit toolchain-funcs eutils

DESCRIPTION="virtual domains for qmail"
SRC_URI="http://www.vmailmgr.org/current/${P}.tar.gz"
HOMEPAGE="http://www.vmailmgr.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=">=sys-apps/ucspi-unix-0.34
	virtual/qmail
	>=net-mail/qmail-autoresponder-0.95
	!>=net-mail/courier-imap-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo-${PR}.patch

	if [ `gcc-major-version` -eq 3 ] && [ `gcc-minor-version` -ge 3 ]; then
		epatch ${FILESDIR}/${P}-gcc3.3.patch
	fi
}

src_compile() {
	export CXX=g++

	if [ `gcc-major-version` -eq 3 ]; then
		export LIBS="-lcrypt -lsupc++"
	elif [ `gcc-major-version` -eq 2 ]; then
		export LIBS="-lcrypt"
	fi

	econf || die "./configure failed"

	emake || die "parallel make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

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
