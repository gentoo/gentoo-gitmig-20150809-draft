# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/email/email-2.3.1.ebuild,v 1.1 2005/01/15 01:17:40 ticho Exp $

inherit eutils

DESCRIPTION="Advanced CLI tool for sending email."
HOMEPAGE="http://email.cleancode.org"
SRC_URI="http://email.cleancode.org/download/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-Makefile.patch
}

src_compile() {
	sed -i -e "s:/doc/email-\${version}:/share/doc:" configure
	sed -i -e "s:DIVIDER = '---':DIVIDER = '-- ':" email.conf

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	doman email.1
	dodoc INSTALL quoted-printable.rfc RFC821 TODO
	dodir /usr/bin
	make DESTDIR=${D} install || die "install failed"
}

pkg_preinst() {
	rm ${D}/usr/share/doc/${P}/email.1
}

pkg_postinst() {
	echo
	einfo "Do not forget to edit /etc/email/email.conf file before using email."
	echo
}
