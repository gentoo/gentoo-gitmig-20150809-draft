# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/maildrop/maildrop-1.5.0-r1.ebuild,v 1.6 2003/03/11 21:11:46 seemant Exp $

IUSE="mysql ldap gdbm berkdb"

S=${WORKDIR}/${P}
DESCRIPTION="Mail delivery agent/filter"
SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
HOMEPAGE="http://www.flounder.net/~mrsam/maildrop/index.html"

DEPEND="dev-lang/perl
	virtual/mta
	>=sys-libs/db-3.2
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	mysql? ( >=dev-db/mysql-3.23.51 )
	ldap? ( >=net-nds/openldap-2.0.23 )"
PROVIDE="virtual/mda"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

# FYI:  There appears to be a problem with maildrop when compiled with gcc-3.2.
# I've tested (and am using) mysql support.  I haven't tested ldap yet.
# - Kyle <nitro@gentoo.org>

inherit flag-o-matic
filter-flags -funroll-loops
filter-flags -fomit-frame-pointer

src_compile() {

	local myconf
	use berkdb && myconf="--with-db=db"
	use mysql && myconf="${myconf} --enable-maildropmysql --with-mysqlconfig=/etc/maildrop/maildropmysql.cf"
	use ldap && myconf="${myconf} --enable-maildropldap --with-ldapconfig=/etc/maildrop/maildropldap.cf"
	
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-devel \
		--enable-userdb \
		--disable-tempdir \
		--enable-syslog=1 \
		--enable-use-flock=1 \
		--enable-maildirquota \
		--enable-use-dotlock=1 \
		--enable-restrict-trusted=1 \
		--enable-trusted-users='root mail daemon postmaster qmaild mmdf vmail' \
		--mandir=/usr/share/man \
		--with-etcdir=/etc \
		--with-default-maildrop=./.maildir/ \
		--enable-sendmail=/usr/sbin/sendmail \
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	local i
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README \
		README.postfix UPGRADE maildroptips.txt
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
	
	if [ -n "`use mysql`" ]
	then
		cp ${S}/maildropmysql.config ${S}/maildropmysql.cf
		sed -e "s:/var/lib/mysql/mysql.sock:/var/run/mysqld/mysqld.sock:" \
		 	${S}/maildropmysql.config > ${S}/maildropmysql.cf
		newins ${S}/maildropmysql.cf maildropmysql.cf
	fi

	use ldap && newins ${S}/maildropldap.config maildropldap.cf
}
