# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/maildrop/maildrop-1.8.0-r1.ebuild,v 1.1 2005/02/13 13:19:18 ferdy Exp $

inherit eutils gnuconfig

DESCRIPTION="Mail delivery agent/filter"
[ -z "${PV/?.?/}" ] && SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
[ -z "${PV/?.?.?/}" ] && SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
[ -z "${SRC_URI}" ] && SRC_URI="http://www.courier-mta.org/beta/courier/${P%%_pre}.tar.bz2"
HOMEPAGE="http://www.courier-mta.org/maildrop/"
S="${WORKDIR}/${P%%_pre}"

SLOT="0"
LICENSE="GPL-2"
# not in keywords due to missing dependencies: ~arm ~s390 ~ppc64
KEYWORDS="~x86 ~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc"
IUSE="mysql ldap gdbm berkdb uclibc debug mysql postgres ldap"

PROVIDE="virtual/mda"

DEPEND="dev-lang/perl
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	!gdbm? ( berkdb? ( >=sys-libs/db-3* ) )
	mysql? ( net-libs/courier-authlib )
	postgres? ( net-libs/courier-authlib )
	ldap? ( net-libs/courier-authlib )"

RDEPEND="${DEPEND}
	dev-lang/perl
	virtual/mta"

src_unpack() {
	unpack ${A}
	cd ${S}
	use uclibc && sed -i -e 's:linux-gnu\*:linux-gnu\*\ \|\ linux-uclibc:' config.sub
	if use gdbm ; then
		use berkdb && einfo "Both gdbm and berkdb selected. Using gdbm."
	else
		if use berkdb ; then
			epatch ${FILESDIR}/maildrop-1.8.0-db4.patch \
				|| die "patch failed."
			export WANT_AUTOCONF="2.5"
			gnuconfig_update
			libtoolize --copy --force
			ebegin "Recreating configure."
				autoconf || die "recreate configure failed."
			eend $?
			cd ${S}/bdbobj
			libtoolize --copy --force
			ebegin "Recreating configure in bdbobj."
				autoconf || die "recreate configure failed."
			eend $?
		else
			einfo "Building without database support"
		fi
	fi
}

src_compile() {
	local myconf

	if use gdbm ; then
		myconf="${myconf} --with-db=gdbm"
	else
		[ use berkdb ] &&  myconf="${myconf} --with-db=db" || \
			myconf="${myconf} --without-db"
	fi

	myconf="${myconf} $(use_enable debug DEBUG)"

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
		--cache-file=${S}/configuring.cache \
		${myconf} || die

	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README \
		README.postfix UPGRADE maildroptips.txt

	dodir /usr/share/doc/${PF}
	mv ${D}/usr/share/maildrop/html ${D}/usr/share/doc/${PF}

	dohtml {INSTALL,README,UPGRADE}.html

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
