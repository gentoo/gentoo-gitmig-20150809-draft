# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/trousers/trousers-0.1.7.ebuild,v 1.1 2005/02/06 08:29:08 dragonheart Exp $

inherit eutils

DESCRIPTION="Trousers is an open-source TCG Software Stack (TSS)"
HOMEPAGE="http://trousers.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/libc
	x11-libs/pango
	>=x11-libs/gtk+-2
	app-crypt/tpm-module
	>=dev-libs/openssl-0.9.7"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7.9
	>=sys-devel/autoconf-2.59
	dev-util/pkgconfig"

pkg_setup() {
	enewgroup tss
	enewuser tss -1 /bin/false /var/state/tpm tss
}


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-makefile-statedir.patch || die "patch failed"
	sed -i -e "s/#undef TPM_IOCTL/#define TPM_IOCTL/" src/include/tddl.h
}
src_compile() {
	aclocal || die "aclocal failed"
	libtoolize --force || die "libtoolize failed"
	WANT_AUTOMAKE=1.7 automake --add-missing -c || die "automake failed"
	WANT_AUTOCONF=2.59 autoconf || die "autoconf failed"

	econf --localstatedir=/var/state || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	keepdir /var/state/tpm
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog LICENSE NICETOHAVES  README  TODO
}
