# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/hotwayd/hotwayd-0.8.2-r1.ebuild,v 1.2 2005/01/21 21:16:31 ticho Exp $

inherit eutils

DESCRIPTION="Hotmail to pop3 daemon"
HOMEPAGE="http://hotwayd.sourceforge.net/"
SRC_URI="mirror://sourceforge/hotwayd/${P}.tar.bz2"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"

IUSE="smtp"

DEPEND="virtual/inetd
	dev-libs/libxml2
	smtp? ( >=dev-libs/cyrus-sasl-2 )"

src_install () {
	# The original make install is broken, since it also tries to install 
	# the libghttp files. This is not needed, since this library is statically
	# linked into the executable.
	# Lets just copy the (one) file manually...
	dosbin hotwayd
	if use smtp; then
		dosbin hotsmtpd/hotsmtpd
		insinto /etc/xinetd.d
		sed -i -e 's:^disable = no:disable = yes:' hotsmtpd/hotsmtpd.xinetd
		newins hotsmtpd/hotsmtpd.xinetd hotsmtpd
	fi

	dodoc AUTHORS NEWS README

	insinto /etc/xinetd.d
	newins ${FILESDIR}/${PN}.xinetd ${PN}
}

pkg_postinst () {
	echo
	einfo " By default daemons that use xinetd are not started automatically in gentoo"
	einfo " To activate do the following steps: "
	einfo " - Edit the file /etc/xinetd.d/hotwayd and change disable "
	einfo "   from yes to no "
	einfo " - Restart xinetd with \`/etc/init.d/xinetd restart\` "
	echo
	if use smtp; then
		einfo "You chose to install hotsmtpd, a SMTP proxy for hotmail. Please"
		einfo "Configure /etc/xinetd.d/hotsmtpd and restart xinetd to start using it."
		echo
	fi
	einfo "Set your e-mail applications to use port 1100 for receiving email."
	if use smtp; then
		einfo "Use port 2500 for sending email."
	fi
}
