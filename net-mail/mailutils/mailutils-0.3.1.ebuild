# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailutils/mailutils-0.3.1.ebuild,v 1.6 2004/07/15 01:50:31 agriffis Exp $

DESCRIPTION="A useful collection of mail servers, clients, and filters."
HOMEPAGE="http://www.gnu.org/software/mailutils/mailutils.html"
SRC_URI="http://ftp.gnu.org/gnu/mailutils/${P}.tar.bz2"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="nls pam mysql gdbm"
DEPEND="!mail-client/mailx
	!mail-client/nmh
	dev-util/guile
	gdbm? ( sys-libs/gdbm )
	mysql? ( dev-db/mysql )
	nls? ( sys-devel/gettext )"

src_compile() {

	use nls || myconf="${myconf} --disable-nls"

	use pam || myconf="${myconf} --disable-pam"

	use mysql && myconf="${myconf} --enable-mysql"

	use gdbm && myconf="${myconf} --with-gdbm"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--infodir=/usr/share/info \
		--sharedstatedir=/var \
		--mandir=/usr/share/man \
		--disable-sendmail \
		${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
