# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/amavis/amavis-0.2.1-r2.ebuild,v 1.8 2002/09/23 20:16:22 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Virus Scanner"
SRC_URI="http://www.amavis.org/dist/${P}.tar.gz"
HOMEPAGE="http://www.amavis.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="net-mail/maildrop
	>=net-mail/tnef-0.13
	>=net-mail/vlnx-407e
	net-mail/qmail"

src_compile() {

	./reconf
	econf \
		--with-logdir=/var/log/scanmail \
		--with-virusdir=/var/tmp/virusmails \
		--enable-qmail || die

	make || die
}

src_install() {

	try make prefix=${D}/usr install
	into /usr
	dodoc AUTHORS BUGS COPYING ChangeLog FAQ HINTS NEWS README* TODO
	dodoc doc/amavis.txt
	dohtml -r doc
	dodir /var/log/scanmail
	dodir /var/tmp/virusmails
	chmod 777 ${D}/var/log/scanmail
	chmod 777 ${D}/var/tmp/virusmails

}
