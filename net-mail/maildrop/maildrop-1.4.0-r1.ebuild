# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/maildrop/maildrop-1.4.0-r1.ebuild,v 1.2 2002/09/12 14:43:26 raker Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Mail delivery agent/filter"
SRC_URI="mirror://sourceforge/courier/${P}.tar.gz"
HOMEPAGE="http://www.flounder.net/~mrsam/maildrop/index.html"

DEPEND=">=sys-libs/gdbm-1.8.0
	sys-devel/perl
	virtual/mta"
RDEPEND="${DEPEND}"
PROVIDE="virtual/mda"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	# These next two lines are a MUST! If tries to unroll the loops in
	# CFLAGS or CXXFLAGS maildrop will not compile :-( <lamer@gentoo.org>
	export CFLAGS="${CFLAGS/-funroll-loops/}"
	export CXXFLAGS="${CXXFLAGS/-funroll-loops/}"
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
