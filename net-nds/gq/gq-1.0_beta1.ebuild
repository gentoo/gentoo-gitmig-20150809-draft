# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/gq/gq-1.0_beta1.ebuild,v 1.3 2004/06/25 00:22:48 agriffis Exp $

S=${WORKDIR}/${PN}-${PV/_/}
DESCRIPTION="GTK-based LDAP client"

SRC_URI="mirror://sourceforge/gqclient/${PN}-${PV/_/}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://www.biot.com/gq/"
IUSE="kerberos jpeg nls ssl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

RDEPEND=">=x11-libs/gtk+-2
	>=net-nds/openldap-2
	kerberos? ( app-crypt/mit-krb5 )
	jpeg? ( media-libs/gdk-pixbuf )
	ssl? ( dev-libs/openssl )
	dev-libs/libxml2
	dev-libs/glib
	sys-devel/gettext
	=dev-libs/atk-1*
	x11-libs/pango
	dev-libs/cyrus-sasl
	virtual/glibc"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-apps/gawk
	sys-devel/bison
	sys-devel/gcc"

src_unpack() {
	unpack ${A} || die
	cd ${S}  || die
	# Fix timestamp skews
	touch aclocal.m4 configure `find . -name Makefile.in`
}

src_compile() {
	local myconf="--enable-browser-dnd --enable-cache"

	use nls \
		&& myconf="${myconf} --with-included-gettext" \
		|| myconf="${myconf} --disable-nls"

	use kerberos && myconf="${myconf} --with-kerberos-prefix=/usr"

	econf $myconf || die "./configure failed"

	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"

	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING NEWS README* TODO
}
