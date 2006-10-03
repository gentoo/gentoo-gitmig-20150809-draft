# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/email/email-2.5.0.ebuild,v 1.2 2006/10/03 11:43:00 ticho Exp $

DESCRIPTION="Advanced CLI tool for sending email."
HOMEPAGE="http://email.cleancode.org"
SRC_URI="http://email.cleancode.org/download/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~alpha ~amd64 x86"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	local myconf=""

	if [ -f /etc/rc.conf ]; then
		. /etc/rc.conf
		if [ x$CLOCK = "xUTC" ]; then
			einfo "Using UTC timestamps (from /etc/rc.conf)"
			myconf="${myconf} --with-utc"
		fi
	fi

	sed -i -e "s:/doc/email-\${version}:/share/doc:" configure
	sed -i -e "s:DIVIDER = '---':DIVIDER = '-- ':" email.conf

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	doman email.1
	dodoc INSTALL quoted-printable.rfc RFC821 TODO
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
