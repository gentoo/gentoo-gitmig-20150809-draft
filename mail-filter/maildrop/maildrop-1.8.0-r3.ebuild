# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/maildrop/maildrop-1.8.0-r3.ebuild,v 1.10 2005/06/30 17:21:41 agriffis Exp $

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
KEYWORDS="alpha ~amd64 ia64 ppc sparc x86"
IUSE="mysql ldap gdbm berkdb debug postgres"

PROVIDE="virtual/mda"

DEPEND="gdbm? ( >=sys-libs/gdbm-1.8.0 )
	!gdbm? ( berkdb? ( >=sys-libs/db-3 ) )
	mysql? ( net-libs/courier-authlib )
	postgres? ( net-libs/courier-authlib )
	ldap? ( net-libs/courier-authlib )"

RDEPEND="${DEPEND}
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Do not use lazy bindings on /usr/bin/maildrop
	sed -i -e 's~^maildrop_LDFLAGS =~& -Wl,-z,now~g' maildrop/Makefile.in
	use elibc_uclibc && sed -i -e 's:linux-gnu\*:linux-gnu\*\ \|\ linux-uclibc:' config.sub
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

	if use gdbm; then
		myconf="${myconf} --with-db=gdbm"
	elif use berkdb; then
		myconf="${myconf} --with-db=db"
	else
		myconf="${myconf} --without-db"
	fi

	if ! use mysql && ! use postgres && ! use ldap ; then
		myconf="${myconf} --disable-authlib"
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
		--enable-maildrop-uid=root \
		--enable-maildrop-gid=mail \
		--with-default-maildrop=./.maildir/ \
		--enable-sendmail=/usr/sbin/sendmail \
		--cache-file=${S}/configuring.cache \
		${myconf} || die

	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die

	fperms 4755 /usr/bin/maildrop

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README \
		README.postfix UPGRADE maildroptips.txt

	dodir /usr/share/doc/${PF}
	mv ${D}/usr/share/maildrop/html ${D}/usr/share/doc/${PF}

	dohtml {INSTALL,README,UPGRADE}.html

	insinto /etc
	doins ${FILESDIR}/maildroprc

	insinto /etc/maildrop
	insopts -m0640
	if use mysql ; then
		sed -e "s:/var/lib/mysql/mysql.sock:/var/run/mysqld/mysqld.sock:" \
		 	${S}/maildropmysql.config > ${S}/maildropmysql.cf
		newins ${S}/maildropmysql.cf maildropmysql.cf
	fi
	use ldap && newins ${S}/maildropldap.config maildropldap.cf
}

pkg_postinst() {
	if use ldap || use mysql ; then
		echo
		ewarn
		ewarn "Due to a security bug (#91465) you should change the permissions of:"
		use ldap && ewarn "   /etc/maildrop/maildropldap.cf"
		use mysql && ewarn "   /etc/maildrop/maildropmysql.cf"
		ewarn "  by running chmod 0640 on them."
		ewarn
		echo
	fi
}
