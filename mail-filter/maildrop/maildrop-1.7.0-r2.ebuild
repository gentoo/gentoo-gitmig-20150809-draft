# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/maildrop/maildrop-1.7.0-r2.ebuild,v 1.2 2004/09/20 07:40:04 ticho Exp $


inherit eutils
IUSE="mysql ldap gdbm berkdb"

DESCRIPTION="Mail delivery agent/filter"
HOMEPAGE="http://www.courier-mta.org/maildrop/"
SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~alpha ~amd64"

DEPEND="dev-lang/perl
	virtual/mta
	berkdb? ( >=sys-libs/db-3* )
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	mysql? ( >=dev-db/mysql-3.23.51 )
	ldap? ( >=net-nds/openldap-2.0.23 )"
PROVIDE="virtual/mda"

src_unpack() {
	unpack ${A}
	cd ${S}
	# patch for db-4.x detection
	epatch ${FILESDIR}/maildrop-1.7.0-db4-configure.in.patch \
		|| die "patch failed."
	epatch ${FILESDIR}/maildrop-1.7.0-db4-bdbobj_configure.in.patch \
		|| die "patch failed."

	ebegin "Recreating configure."
	autoconf || die "recreate configure failed."
	eend $?

	ebegin "Recreating configure in bdbobj."
	cd ${S}/bdbobj
	autoconf || die "recreate configure failed."
	eend $?
	cd ${S}
}

src_compile() {
	local myconf
	use mysql \
		&& myconf="${myconf} --enable-maildropmysql \
			--with-mysqlconfig=/etc/maildrop/maildropmysql.cf" \
		|| myconf="${myconf} --disable-maildropmysql"

	use ldap \
		&& myconf="${myconf} --enable-maildropldap \
			--with-ldapconfig=/etc/maildrop/maildropldap.cf" \
		|| myconf="${myconf} --disable-maildropldap"

	if use gdbm; then
		# both flags present; default to gdbm.
		einfo "build with GDBM support."
		myconf="${myconf} --with-db=gdbm \
		--enable-userdb"
	elif use berkdb; then
		einfo "build with DB support."
		myconf="${myconf} --with-db=db \
		--enable-userdb"
	else
		# without a db library support, can't build this.
		einfo "moving ${S}/makedat to ${S}/makedat.org"
		mv ${S}/makedat ${S}/makedat.org || "failed to move makedat."
		einfo "build without-db."
		myconf="${myconf} --without-db"
	fi

	econf \
		--with-devel \
		--disable-tempdir \
		--enable-syslog=1 \
		--enable-use-flock=1 \
		--enable-maildirquota \
		--enable-use-dotlock=1 \
		--enable-restrict-trusted=1 \
		--enable-trusted-users='apache dspam root mail daemon postmaster qmaild mmdf vmail' \
		--with-default-maildrop=./.maildir/ \
		--enable-sendmail=/usr/sbin/sendmail \
		${myconf} || die

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

	insinto /etc
	doins ${FILESDIR}/maildroprc

	insinto /etc/maildrop
	if use mysql
	then
		sed -e "s:/var/lib/mysql/mysql.sock:/var/run/mysqld/mysqld.sock:" \
		 	${S}/maildropmysql.config > ${S}/maildropmysql.cf
		newins ${S}/maildropmysql.cf maildropmysql.cf
	fi
	use ldap && newins ${S}/maildropldap.config maildropldap.cf
}

