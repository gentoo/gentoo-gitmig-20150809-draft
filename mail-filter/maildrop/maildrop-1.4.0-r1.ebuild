# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/maildrop/maildrop-1.4.0-r1.ebuild,v 1.3 2004/07/14 16:43:08 agriffis Exp $

DESCRIPTION="Mail delivery agent/filter"
SRC_URI="mirror://sourceforge/courier/${P}.tar.gz"
HOMEPAGE="http://www.flounder.net/~mrsam/maildrop/index.html"

DEPEND=">=sys-libs/gdbm-1.8.0
	dev-lang/perl
	virtual/mta"
PROVIDE="virtual/mda"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""

inherit flag-o-matic
filter-flags -funroll-loops
filter-flags -fomit-frame-pointer

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
		--with-etcdir=/etc \
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
		mv -f ${D}/usr/share/maildrop/scripts/$i \
			${D}/usr/share/maildrop
		dosym /usr/share/maildrop/$i /usr/bin/$i
	done
	rm -rf ${D}/usr/share/maildrop/scripts

	insinto /etc/maildrop
	doins ${FILESDIR}/maildroprc
}
