# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gnunet/gnunet-0.6.6b.ebuild,v 1.1 2005/04/01 16:10:24 augustus Exp $

inherit eutils libtool

S="${WORKDIR}/GNUnet-${PV}"
DESCRIPTION="GNUnet is an anonymous, distributed, reputation based network."
HOMEPAGE="http://www.gnu.org/software/GNUnet/"
SRC_URI="mirror://gnu//${PN}/GNUnet-${PV}.tar.bz2"
RESTRICT="nomirror"

IUSE="ipv6 gtk mysql sqlite"
KEYWORDS="~x86 ~ppc ~amd64"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=sys-libs/gdbm-1.8.0
	>=dev-libs/libgcrypt-1.2.0
	gtk? ( >=x11-libs/gtk+-2.4.0 )
	mysql? ( >=dev-db/mysql-3.23-56 )
	sqlite? ( >=dev-db/sqlite-3.0.8 )
	sys-devel/gettext
	>=media-libs/libextractor-0.3.1
	>=dev-libs/gmp-4.0.0"

pkg_preinst() {
	enewgroup gnunet || die "Problem adding gnunet group"
	enewuser gnunet -1 /bin/false /dev/null gnunet || die "Problem adding gnunet user"
}

src_compile() {
	elibtoolize

	local myconf
	use gtk || myconf="${myconf} --without-gtk"
	use mysql && myconf="${myconf} --with-mysql"
	use sqlite && myconf="${myconf} --with-sqlite"

	if use ipv6; then
		if use amd64; then
			ewarn "ipv6 in GNUnet does not currently work with amd64 and has been disabled"
		else
			myconf="${myconf} --enable-ipv6"
		fi
	fi

	econf ${myconf} || die "econf failed"

	emake || MAKEOPTS="${MAKEOPTS} -j1" emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING INSTALL NEWS PLATFORMS README	README.fr UPDATING
	insinto /etc
	newins contrib/gnunet.root gnunet.conf
	docinto contrib
	dodoc contrib/*
	exeinto /etc/init.d
	newexe ${FILESDIR}/gnunet-0.6.6b gnunet
}

pkg_postinst() {
	# make sure permissions are ok
	chown -R gnunet:gnunet /var/lib/GNUnet

	use ipv6 && ewarn "ipv6 support is -very- experimental and prone to bugs"
	einfo
	einfo "If you want to run GNUnet as a user"
	einfo "copy an appropriate config file from"
	einfo "/usr/share/doc/${P}/contrib"
	einfo "to ~/.gnunet/gnunet.conf"
	einfo
	einfo "It is also possible to run GNUnet as"
	einfo "a system service. You can start it by"
	einfo "running /etc/init.d/gnunet start"
	einfo "The config file is in /etc/gnunet.conf"
}

