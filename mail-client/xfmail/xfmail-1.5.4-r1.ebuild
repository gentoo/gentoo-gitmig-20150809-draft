# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/xfmail/xfmail-1.5.4-r1.ebuild,v 1.5 2006/02/25 12:11:56 ticho Exp $

IUSE="ldap"
DESCRIPTION="A full-featured mail program using XForms"
SRC_URI="http://xfmail.precision-eng.net/release/${PV}/source/${P}-1.tar.bz2
	http://xfmail.cfreeze.com/release/${PV}/source/${P}-1.tar.bz2
	ftp://ftp.xfmail.org/pub/xfmail/release/${PV}/source/${P}-1.tar.bz2"
HOMEPAGE="http://www.xfmail.org"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

RDEPEND="|| ( ( x11-libs/libXpm
				x11-libs/libSM )
			virtual/x11 )
		=dev-libs/glib-1.2*
		sys-libs/gdbm
		>=x11-libs/xforms-1.0_rc4
		ldap? ( >=net-nds/openldap-2.0.11 )"
DEPEND="${RDEPEND}
		|| ( ( x11-proto/xextproto
				x11-libs/libXt )
			virtual/x11 )
		sys-apps/sed"

src_compile() {
	local myconf
	use ldap && myconf="$myconf --with-ldap"
	./autogen.sh \
		--host=${CHOST}  \
		--prefix=/usr \
		--with-faces $myconf || die
	emake || die
}

src_install () {
	make prefix=${D}/usr \
		manualdir=${D}/usr/share/doc/${PF}/html \
		install || die
	dodoc AUTHORS ChangeLog* NEWS README* TODO*
}
