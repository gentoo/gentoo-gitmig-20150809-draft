# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/maildrop/maildrop-1.3.8.ebuild,v 1.1 2002/05/02 02:08:33 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Mail delivery agent/filter"
SRC_URI="http://download.sourceforge.net/courier/${P}.tar.gz"
HOMEPAGE="http://www.flounder.net/~mrsam/maildrop/index.html"

DEPEND="virtual/glibc >=sys-libs/gdbm-1.8.0 sys-devel/perl"
SLOT="0"
LICENSE="GPL-2"

src_compile() {
	./configure \
		--prefix=/usr \
		--with-devel \
		--enable-userdb \
		--disable-tempdir \
		--enable-syslog=1 \
		--enable-use-flock=1 \
		--enable-maildirquota \
		--enable-use-dotlock=1 \
		--mandir=/usr/share/man \
		--with-etcdir=/etc/maildrop \
		--with-default-maildrop=./.maildir/ \
		--enable-sendmail=/usr/sbin/sendmail \
		--host=${CHOST} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	local i
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README \
		README.postfix UPGRADE
	mv ${D}/usr/share/maildrop/html ${D}/usr/share/doc/${PF}
	dohtml {INSTALL,README,UPGRADE}.html

	# this just cleans up /usr/share/maildrop a little bit..
	for i in makedat makeuserdb pw2userdb userdb userdbpw vchkpw2userdb
	do
		rm -f ${D}/usr/bin/$i
		mv -f ${D}/usr/share/maildrop/scripts/$i ..
		dosym /usr/share/maildrop/$i /usr/bin/$i
	done
	rm -rf ${D}/usr/share/maildrop/scripts

	insinto /etc/maildrop
	doins ${FILESDIR}/maildroprc
}
