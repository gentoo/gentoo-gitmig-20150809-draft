# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/bincimap/bincimap-1.2.6.ebuild,v 1.3 2004/03/28 05:01:45 nakano Exp $

DESCRIPTION="IMAP server for Maildir"
SRC_URI="http://www.bincimap.org/dl/tarballs/1.2/${P}final.tar.bz2"
HOMEPAGE="http://www.bincimap.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="ssl"

DEPEND="virtual/glibc
	ssl? ( dev-libs/openssl )"

RDEPEND="${DEPEND}
	sys-apps/daemontools
	sys-apps/ucspi-tcp
	net-mail/checkpassword"

S="${WORKDIR}/${P}final"

src_compile() {
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	econf `use_enable ssl ssl` --sysconfdir=/etc/bincimap || die
	emake || die
}

src_install () {
	cd ${S}
	einstall sysconfdir=${D}/etc/bincimap || die
	keepdir /var/log/bincimap || die
	if [ `use ssl` ]; then
		keepdir /var/log/bincimap-ssl || die
	fi

	dodoc AUTHORS COPYING COPYING.OpenSSL ChangeLog INSTALL \
		NEWS README TODO

	cd doc
	dodoc *.html
	dodoc manual/bincimap-manual.dvi manual/bincimap-manual.ps
}

pkg_postinst() {
	if [ `use ssl` ]; then
		einfo "This command will setup bincimap-ssl on your system."
		einfo "ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
	fi

	einfo "To start bicimap at boot you have to enable the /etc/init.d/svscan rc file"
	einfo "and create the following links:"
	einfo "ln -s /var/lib/service/imap /service/imap"

	einfo "If you want to use ssl connections, create the following links: "
	einfo "ln -s /var/lib/service/imaps /service/imaps"
}

pkg_config() {
	if [ `use ssl` ]; then
		local pemfile=/etc/bincimap/bincimap.pem
		if [ ! -f $pemfile ]; then
			echo "Creating a self-signed ssl-cert:"
			/usr/bin/openssl req -new -x509 -nodes -out $pemfile -days 366 -keyout $pemfile
			chmod 640 $pemfile

			einfo "If You want to have a signed cert, do the following:"
			einfo "openssl req -new -nodes -out req.pem \\"
			einfo "-keyout $pemfile"
			einfo "chmod 640 $pemfile"
			einfo "Send req.pem to your CA to obtain signed_req.pem, and do:"
			einfo "cat signed_req.pem >> $pemfile"
		fi
	fi
}
