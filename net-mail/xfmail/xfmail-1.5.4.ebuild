# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/xfmail/xfmail-1.5.4.ebuild,v 1.2 2003/02/13 14:44:12 vapier Exp $

IUSE="ldap"
S=${WORKDIR}/${P}
DESCRIPTION="A full-featured mail program using XForms"
SRC_URI="http://xfmail.precision-eng.net/release/1.5.4/source/${P}.tar.bz2
	http://xfmail.cfreeze.com/release/1.5.4/source/${P}.tar.bz2
	ftp://ftp.xfmail.org/pub/${PN}/release/1.5.4/source/${P}.tar.bz2"
HOMEPAGE="http://www.xfmail.org"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"
DEPEND="virtual/x11
	>=x11-libs/xforms-1.0_rc4
	ldap? ( >=net-nds/openldap-2.0.11 )"
RDEPEND="virtual/x11
	>=x11-libs/xforms-1.0_rc4
	ldap? ( >=net-nds/openldap-2.0.11 )"

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
