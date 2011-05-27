# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/maildrop/maildrop-2.5.4.ebuild,v 1.1 2011/05/27 13:50:51 eras Exp $

EAPI=4

inherit eutils flag-o-matic autotools

DESCRIPTION="Mail delivery agent/filter"
[[ -z ${PV/?.?/}   ]] && SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
[[ -z ${PV/?.?.?/} ]] && SRC_URI="mirror://sourceforge/courier/${P}.tar.bz2"
[[ -z ${SRC_URI}   ]] && SRC_URI="http://www.courier-mta.org/beta/${PN}/${P%%_pre}.tar.bz2"
HOMEPAGE="http://www.courier-mta.org/maildrop/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="berkdb debug fam gdbm ldap mysql postgres authlib"

CDEPEND="!mail-mta/courier
	net-mail/mailbase
	dev-libs/libpcre
	net-dns/libidn
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
DEPEND="${CDEPEND}
	dev-util/pkgconfig"
RDEPEND="${CDEPEND}
	dev-lang/perl"
REQUIRED_USE="mysql? ( authlib )
			postgres? ( authlib )
			ldap? ( authlib )"

S=${WORKDIR}/${P%%_pre}

src_prepare() {
	# Prefer gdbm over berkdb
	if use gdbm ; then
		use berkdb && elog "Both gdbm and berkdb selected. Using gdbm."
	elif use berkdb ; then
		epatch "${FILESDIR}"/${PN}-2.5.1-db.patch
	fi

	if ! use fam ; then
		epatch "${FILESDIR}"/${PN}-1.8.1-disable-fam.patch
	fi

	eautoreconf
}

src_configure() {
	local myconf
	local mytrustedusers="apache dspam root mail fetchmail \
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
		--enable-use-dotlock=1 \
		--enable-restrict-trusted=1 \
		--enable-trusted-users="${mytrustedusers}" \
		--enable-maildrop-uid=root \
		--enable-maildrop-gid=mail \
		--with-default-maildrop=./.maildir/ \
		--enable-sendmail=/usr/sbin/sendmail \
		--cache-file="${S}"/configuring.cache \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install

	fperms 4755 /usr/bin/maildrop

	dodoc AUTHORS ChangeLog INSTALL NEWS README \
		README.postfix UPGRADE maildroptips.txt
	docinto unicode
	dodoc unicode/README
	docinto maildir
	dodoc maildir/AUTHORS maildir/INSTALL maildir/README*.txt

	dodir "/usr/share/doc/${PF}"
	mv "${D}/usr/share/maildrop/html" "${D}/usr/share/doc/${PF}/"
	rm -rf "${D}"/usr/share/maildrop

	dohtml *.html maildir/*.html

	insinto /etc
	doins "${FILESDIR}"/maildroprc
}
