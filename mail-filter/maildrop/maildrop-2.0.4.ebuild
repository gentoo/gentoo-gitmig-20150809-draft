# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/maildrop/maildrop-2.0.4.ebuild,v 1.3 2007/08/13 22:34:35 ferdy Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit eutils flag-o-matic autotools

DESCRIPTION="Mail delivery agent/filter"
[[ -z ${PV/?.?/}   ]] && SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
[[ -z ${PV/?.?.?/} ]] && SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
[[ -z ${SRC_URI}   ]] && SRC_URI="http://www.courier-mta.org/beta/${PN}/${P%%_pre}.tar.bz2"
HOMEPAGE="http://www.courier-mta.org/maildrop/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sh ~sparc ~x86"
IUSE="berkdb debug fam gdbm ldap mysql postgres authlib"

DEPEND="!mail-mta/courier
	net-mail/mailbase
	dev-libs/libpcre
	gdbm?     ( >=sys-libs/gdbm-1.8.0 )
	mysql?    ( net-libs/courier-authlib )
	postgres? ( net-libs/courier-authlib )
	ldap?     ( net-libs/courier-authlib )
	authlib?  ( net-libs/courier-authlib )
	fam?      ( virtual/fam )
	!gdbm? (
		berkdb? (
			>=sys-libs/db-3
		)
	)"
RDEPEND="${DEPEND}
	dev-lang/perl"
PROVIDE="virtual/mda"

S=${WORKDIR}/${P%%_pre}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-makedat.patch

	# Prefer gdbm over berkdb
	if use gdbm ; then
		use berkdb && elog "Both gdbm and berkdb selected. Using gdbm."
	elif use berkdb ; then
			epatch "${FILESDIR}"/${PN}-1.8.0-db4-r1.patch
	fi

	if ! use fam ; then
		epatch "${FILESDIR}"/${PN}-1.8.1-disable-fam.patch
	fi

	eautoreconf
}

src_compile() {
	local myconf
	local mytrustedusers="apache dspam root mail \
		daemon postmaster qmaild mmdf vmail alias"

	# These flags make maildrop cry
	replace-flags -Os -O2
	filter-flags -fomit-frame-pointer

	if use gdbm ; then
		myconf="${myconf} --with-db=gdbm"
	elif use berkdb ; then
		myconf="${myconf} --with-db=db"
	else
		myconf="${myconf} --without-db"
	fi

	if ! use mysql && ! use postgres && ! use ldap && ! use authlib ; then
		myconf="${myconf} --disable-authlib"
	fi

	econf \
		$(use_enable fam) \
		--disable-dependency-tracker \
		--with-devel \
		--disable-tempdir \
		--enable-syslog=1 \
		--enable-use-flock=1 \
		--enable-maildirquota \
		--enable-use-dotlock=1 \
		--enable-restrict-trusted=1 \
		--enable-trusted-users="${mytrustedusers}" \
		--enable-maildrop-uid=root \
		--enable-maildrop-gid=mail \
		--with-default-maildrop=./.maildir/ \
		--enable-sendmail=/usr/sbin/sendmail \
		--cache-file="${S}"/configuring.cache \
		${myconf} || die

	emake || die "compile problem"
}

src_install() {
	make DESTDIR="${D}" install || die

	fperms 4755 /usr/bin/maildrop

	dodoc AUTHORS ChangeLog INSTALL NEWS README \
		README.postfix UPGRADE maildroptips.txt

	dodir /usr/share/doc/${PF}
	mv "${D}"/usr/share/maildrop/html "${D}"/usr/share/doc/${PF}/

	dohtml {INSTALL,README,UPGRADE}.html

	insinto /etc
	doins "${FILESDIR}"/maildroprc
}
