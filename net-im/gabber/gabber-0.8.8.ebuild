# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gabber/gabber-0.8.8.ebuild,v 1.11 2004/01/14 18:34:10 agriffis Exp $

inherit flag-o-matic gcc

S="${WORKDIR}/${P}"
DESCRIPTION="The GNOME Jabber Client"
SRC_URI="mirror://sourceforge/gabber/${P}.tar.gz"
HOMEPAGE="http://gabber.sourceforge.net"

IUSE="ssl crypt xmms"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~alpha"

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

	if [ "`gcc-major-version`" -eq 3 -a "`gcc-minor-version`" -ge 3 ]
	then
		cd ${S}; epatch ${FILESDIR}/${P}-gcc33.patch
	fi
}

src_compile() {
	replace-flags "-O3" "-O2"

	CFLAGS="${CFLAGS} -I/usr/include"

	local myconf=

	use ssl \
		&& myconf="${myconf} --with-ssl-dir=/usr" \
		|| myconf="${myconf} --disable-ssl"

	# ipv6 not enabled because it doesn't work for this release - liquidx

	econf ${myconf} \
		`use_enable xmms` \
		`use_enable nls` || die "configure failed"

	emake || die "make failed"
}

src_install() {
	einstall || die
	# make sure we don't overwrite the scrollkeeper db
	rm -rf ${D}/var/lib/scrollkeeper
}
