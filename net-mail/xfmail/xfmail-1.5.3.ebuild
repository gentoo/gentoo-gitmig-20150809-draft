# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/xfmail/xfmail-1.5.3.ebuild,v 1.2 2002/12/09 04:33:15 manson Exp $

IUSE="ldap"

S=${WORKDIR}/${P}

DESCRIPTION="A full-featured mail program using XForms"
SRC_URI="ftp://ftp.xfmail.org/pub/${PN}/release/1.5.3/source/${P}.tar.bz2"
HOMEPAGE="http://www.xfmail.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

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

