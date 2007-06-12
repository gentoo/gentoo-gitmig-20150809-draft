# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/ixbiff/ixbiff-0.03b.ebuild,v 1.4 2007/06/12 12:31:41 genone Exp $

inherit eutils

DESCRIPTION="Ixbiff blinks the keyboard LEDs on new mail"
HOMEPAGE="http://ixbiff.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"
IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=""

src_compile() {
	# This first one is to set the configuration correctly
	# The init script installed later also needs to be configured
	# for a gentoo system
	epatch ${FILESDIR}/ixbiff_0.03b-config-gentoo.patch
	# This second one is because gcc was complaining about the
	# default case in a switch statement
	epatch ${FILESDIR}/ixbiff_0.03b-main.c-gentoo.patch

	make || die
}

src_install () {
	# Building in "default" mode means that these variables have to be overriden
	# if we don't want sandbox violations
	make prefix=${D} sysconfdir=${D}/etc localstatedir=${D}/var install || die

	newinitd src/ixbiff.sh ixbiff

	doman man/*.1 man/*.5
	dohtml doc/*.html
}

pkg_postinst () {
	elog "Use rc-update to add ixbiff to the startup sequence."
}
