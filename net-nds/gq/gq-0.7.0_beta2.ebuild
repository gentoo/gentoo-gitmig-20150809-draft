# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/gq/gq-0.7.0_beta2.ebuild,v 1.1 2003/06/16 19:37:58 woodchip Exp $

S=${WORKDIR}/${PN}-${PV/_/}
DESCRIPTION="GTK-based LDAP client"

SRC_URI="mirror://sourceforge/gqclient/${PN}-${PV/_/}.tar.gz"
HOMEPAGE="http://www.biot.com/gq/"
IUSE="kerberos jpeg nls ssl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND="=x11-libs/gtk+-1.2*
	>=net-nds/openldap-2
	kerberos? ( app-crypt/mit-krb5 )
	jpeg? ( media-libs/gdk-pixbuf )
	ssl? ( dev-libs/openssl )"

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
