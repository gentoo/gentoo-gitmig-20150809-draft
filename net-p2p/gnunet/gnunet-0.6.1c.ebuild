# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnunet/gnunet-0.6.1c.ebuild,v 1.1 2004/03/23 07:00:55 eradicator Exp $

inherit libtool

S="${WORKDIR}/GNUnet-${PV}"
DESCRIPTION="GNUnet is an anonymous, distributed, reputation based network."
HOMEPAGE="http://www.ovmj.org/GNUnet/"
SRC_URI="http://www.ovmj.org/GNUnet/download/GNUnet-${PV}.tar.bz2"

IUSE="ipv6 gtk crypt mysql"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=dev-libs/openssl-0.9.6d
	>=sys-libs/gdbm-1.8.0
	crypt? ( dev-libs/libgcrypt )
	gtk? ( =x11-libs/gtk+-1.2* )
	mysql? ( dev-db/mysql )
	>=dev-libs/libextractor-0.2.6"

src_compile() {
	elibtoolize

	local myconf

	if ! use gtk; then
		myconf="${myconf} --without-gtk"
	fi

	if ! use crypt; then
		myconf="${myconf} --without-gcrypt"
	fi

	if ! use mysql; then
		myconf="${myconf} --without-mysql"
	fi

	econf ${myconf} `use_enable ipv6` || die

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog PLATFORMS README UPDATING
	insinto /etc
	newins contrib/gnunet.root gnunet.conf
	docinto contrib
	dodoc contrib/*
}

pkg_postinst() {
	use ipv6 && ewarn "ipv6 support is -very- experimental and prone to bug"
	einfo
	einfo "now copy an appropriate config file from"
	einfo "/usr/share/doc/${P}/contrib"
	einfo "to ~/.gnunet/gnunet.conf"
	einfo
}
