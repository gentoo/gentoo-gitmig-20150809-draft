# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qpage/qpage-3.3.ebuild,v 1.3 2004/03/24 04:33:45 mr_bones_ Exp $

inherit eutils

IUSE="tcpd"

DESCRIPTION="Sends messages to an alphanumeric pager"
HOMEPAGE="http://www.qpage.org/"
SRC_URI="http://www.qpage.org/download/${P}.tar.Z"
LICENSE="qpage"
SLOT="0"
KEYWORDS="~x86 ~alpha"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )
	!tcpd? ( >=sys-apps/sed-4 )"
RDEPEND="
	tcpd? ( sys-apps/tcp-wrappers )
	virtual/mta"

src_unpack() {
	unpack ${A} || die "unpack failed"
	cd ${S}	    || die "cd failed"
	epatch ${FILESDIR}/qpage-3.3-gentoo.patch || die "epatch failed"
}

src_compile() {
	econf || die "econf failed"

	# There doesn't seem to be a clean way to disable tcp wrappers in
	# this package if you have it installed, but don't want to use it.
	if ! use tcpd; then
		sed -i 's/-lwrap//g; s/-DTCP_WRAPPERS//g' Makefile
		echo '#undef TCP_WRAPPERS' >> config.h
	fi

	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	dodir /var/spool/qpage
	fowners daemon:daemon /var/spool/qpage
	fperms 770 /var/spool/qpage

	dodir /var/lock/subsys/qpage
	fowners daemon:daemon /var/lock/subsys/qpage
	fperms 770 /var/lock/subsys/qpage

	dodir /etc/qpage
	insinto /etc/qpage
	doins example.cf		|| die "doins example.cf failed"

	insopts -m0755
	insinto /etc/init.d
	doins ${FILESDIR}/qpage	|| die "doins qpage failed"
}

pkg_postinst() {
	einfo
	einfo "Post-installation tasks:"
	einfo
	einfo "1. Create /etc/qpage/qpage.cf (see example.cf in that dir)."
	einfo "2. Insure that the serial port selected in qpage.cf"
	einfo "   is writable by user or group daemon."
	einfo "3. Set automatic startup with rc-update add qpage default"
	einfo "4. Send mail to tomiii@qpage.org telling him how"
	einfo "   you like qpage! :-)"
	einfo
}
