# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gabber/gabber-0.8.7.12.ebuild,v 1.15 2005/03/30 07:23:45 luckyduck Exp $

inherit flag-o-matic

DESCRIPTION="The GNOME Jabber Client"
# we only have this one on our distfiles
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://gabber.sourceforge.net"

IUSE="crypt nls ssl xmms"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND=">=gnome-base/gnome-libs-1.4.1.7
	<gnome-base/libglade-2.0.0
	<gnome-extra/gal-1.99
	>=dev-cpp/gnomemm-1.2.2
	<dev-cpp/gtkmm-1.3.0
	ssl? ( >=dev-libs/openssl-0.9.6 )
	crypt? ( >=app-crypt/gnupg-1.0.5 )
	xmms? ( >=media-sound/xmms-1.2.7* )"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}/omf-install
	sed -i -e "s/-scrollkeeper-update.*//" Makefile.in
}

src_compile() {
	replace-flags "-O3" "-O2"

	CFLAGS="${CFLAGS} -I/usr/include"

	local myconf

	use ssl \
		&& myconf="${myconf} --with-ssl-dir=/usr" \
		|| myconf="${myconf} --disable-ssl"
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"
	use xmms \
		&& myconf="${myconf} --enable-xmms" \
	        || myconf="${myconf} --disable-xmms"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	# make sure we don't overwrite the scrollkeeper db
	rm -rf ${D}/var/lib/scrollkeeper
}
