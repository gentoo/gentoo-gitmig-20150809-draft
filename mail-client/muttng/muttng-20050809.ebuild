# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/muttng/muttng-20050809.ebuild,v 1.1 2005/08/10 22:01:08 agriffis Exp $

inherit eutils

DESCRIPTION="mutt-ng is the next generation of mutt."
HOMEPAGE="http://www.muttng.org/"
SRC_URI="http://nion.modprobe.de/mutt-ng/snapshots/${P}.tar.gz"
IUSE="crypt debug gnutls gdbm gpgme idn imap mbox nls nntp qdbm sasl slang smtp ssl"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86 ~sparc"
RDEPEND="nls? ( sys-devel/gettext )
	>=sys-libs/ncurses-5.2
	idn?     ( net-dns/libidn )
	qdbm?	 ( dev-db/qdbm )
	!qdbm?	 ( gdbm?  ( sys-libs/gdbm ) 
	           !gdbm? ( berkdb? ( >=sys-libs/db-4 ) ) )
	smtp?    ( net-libs/libesmtp )
	slang?   ( >=sys-libs/slang-1.4.2 )
	gnutls?  ( >=net-libs/gnutls-1.0.17 )
	!gnutls? ( ssl? ( >=dev-libs/openssl-0.9.6 ) )
	gpgme?   ( >=app-crypt/gpgme-0.9.0 )
	sasl?    ( >=dev-libs/cyrus-sasl-2 )"
DEPEND="${RDEPEND}
	sys-devel/automake
	>=sys-devel/autoconf-2.5
	net-mail/mailbase"

src_unpack() {
	unpack ${P}.tar.gz && cd ${S}	|| die "unpacking failed"

	# disable sgml conversion since it fails with sgml2html
	epatch ${FILESDIR}/muttng-20050809-nodoc.patch

	aclocal -I m4					|| die "aclocal failed"
	autoheader						|| die "autoheader failed"
	make -C m4 -f Makefile.am.in	|| die "make in m4 failed"
	automake --foreign				|| die "automake failed"
	WANT_AUTOCONF=2.5 autoconf		|| die "autoconf failed"
}

src_compile() {
	declare myconf="
		$(use_enable nls) \
		$(use_enable gpgme) \
		$(use_enable imap) \
		$(use_with sasl sasl2) \
		$(use_enable crypt pgp) \
		$(use_enable nntp) \
		$(use_enable debug) \
		$(use_with smtp libesmtp) \
		$(use_with idn) \
		--enable-compressed \
		--sysconfdir=/etc/muttng \
		--with-docdir=/usr/share/doc/muttng-${PVR} \
		--with-regex \
		--enable-pop \
		--disable-fcntl \
		--enable-flock \
		--with-mixmaster \
		--enable-external-dotlock"

	# muttng prioritizes qdbm over gdbm, so we will too.
	# hcache feature requires at least one database is in USE.
	if use qdbm; then
		myconf="${myconf} --enable-hcache \
			--with-qdbm --without-gdbm --without-bdb"
	elif use gdbm; then
		myconf="${myconf} --enable-hcache \
			--with-gdbm --without-qdbm --without-bdb"
	elif use berkdb; then
		myconf="${myconf} --enable-hcache \
			--with-bdb=/usr/include --without-gdbm --without-qdbm"
	else
		myconf="--disable-hcache --without-gdbm --without-qdbm --without-bdb"
	fi

	if useq gnutls; then
		myconf="${myconf} --with-gnutls"
	elif useq ssl; then
		myconf="${myconf} --with-ssl"
	fi

	if useq slang; then
		myconf="${myconf} --with-slang"
		ewarn "To use a transparend background merge muttng with USE=-slang"
	else
		# --without-slang doesn't work;
		# specify --with-curses if you don't want slang
		myconf="${myconf} --with-curses"
	fi

	if useq mbox; then
		myconf="${myconf} --with-maildir=/var/spool/mail"
	else
		myconf="${myconf} --with-homespool=Maildir"
	fi

	econf ${myconf}
	emake || die "emake failed (myconf=${myconf})"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	find ${D}/usr/share/doc -type f | grep -v "html\|manual" | xargs gzip
	if useq mbox; then
		insinto /etc/muttng
		newins ${FILESDIR}/Muttngrc.mbox Muttngrc
	else
		insinto /etc/muttng
		doins ${FILESDIR}/Muttngrc
	fi

	dodoc BEWARE COPYRIGHT ChangeLog NEWS OPS* PATCHES README* TODO VERSION
}

pkg_postinst() {
	echo
	einfo "NOTE: muttng is still under heavy development"
	einfo "If you find a bug please report at http://bugs.gentoo.org"
	echo
}
