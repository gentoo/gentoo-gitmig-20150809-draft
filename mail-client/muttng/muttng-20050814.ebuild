# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/muttng/muttng-20050814.ebuild,v 1.1 2005/08/15 13:20:54 agriffis Exp $

inherit eutils flag-o-matic

DESCRIPTION="mutt-ng -- fork of mutt with added features"
HOMEPAGE="http://www.muttng.org/"
SRC_URI="http://nion.modprobe.de/mutt-ng/snapshots/${P}.tar.gz"
IUSE="berkdb buffysize cjk crypt debug gdbm gnutls gpgme idn imap mbox nls nntp pop qdbm sasl slang smime smtp ssl"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86 ~sparc"
RDEPEND="nls? ( sys-devel/gettext )
	>=sys-libs/ncurses-5.2
	idn?     ( net-dns/libidn )
	qdbm?	 ( dev-db/qdbm )
	!qdbm?	 (
		gdbm?  ( sys-libs/gdbm )
		!gdbm? ( berkdb? ( >=sys-libs/db-4 ) )
	)
	slang?   ( >=sys-libs/slang-1.4.2 )
	smtp?    ( net-libs/libesmtp )
	imap?    (
		gnutls?  ( >=net-libs/gnutls-1.0.17 )
		!gnutls? ( ssl? ( >=dev-libs/openssl-0.9.6 ) )
		sasl?    ( >=dev-libs/cyrus-sasl-2 )
	)
	pop?     (
		gnutls?  ( >=net-libs/gnutls-1.0.17 )
		!gnutls? ( ssl? ( >=dev-libs/openssl-0.9.6 ) )
		sasl?    ( >=dev-libs/cyrus-sasl-2 )
	)
	gpgme?   ( >=app-crypt/gpgme-0.9.0 )"
DEPEND="${RDEPEND}
	sys-devel/automake
	>=sys-devel/autoconf-2.5
	net-mail/mailbase"

src_unpack() {
	unpack ${P}.tar.gz && cd ${S} || die "unpack failed"

	# disable sgml conversion since it fails with sgml2html
	epatch ${FILESDIR}/muttng-20050809-nodoc.patch

	aclocal -I m4					|| die "aclocal failed"
	autoheader						|| die "autoheader failed"
	emake -C m4 -f Makefile.am.in	|| die "emake in m4 failed"
	automake --foreign				|| die "automake failed"
	WANT_AUTOCONF=2.5 autoconf		|| die "autoconf failed"
}

src_compile() {
	declare myconf="
		$(use_enable nls) \
		$(use_enable gpgme) \
		$(use_enable imap) \
		$(use_enable pop) \
		$(use_enable crypt pgp) \
		$(use_enable smime) \
		$(use_enable cjk default-japanese) \
		$(use_enable debug) \
		$(use_enable nntp) \
		$(use_with idn) \
		$(use_with smtp libesmtp) \
		--enable-compressed \
		--sysconfdir=/etc/${PN} \
		--with-docdir=/usr/share/doc/${PN}-${PVR} \
		--with-regex \
		--disable-fcntl --enable-flock --enable-nfs-fix \
		--with-mixmaster \
		--without-sasl \
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
			--with-bdb --without-gdbm --without-qdbm"
	else
		myconf="${myconf} --disable-hcache \
			--without-gdbm --without-qdbm --without-bdb"
	fi

	# there's no need for gnutls or ssl without either pop or imap.
	# in fact mutt's configure will bail if you do:
	#   --without-pop --without-imap --with-ssl
	if use pop || use imap; then
		if use gnutls; then
			myconf="${myconf} --with-gnutls"
		elif use ssl; then
			myconf="${myconf} --with-ssl"
		fi
		# not sure if this should be mutually exclusive with the other two
		myconf="${myconf} $(use_with sasl sasl2)"
	else
		myconf="${myconf} --without-gnutls --without-ssl --without-sasl2"
	fi

	# See Bug #11170
	case ${ARCH} in
		alpha|ppc) replace-flags "-O[3-9]" "-O2" ;;
	esac

	if use buffysize; then
		ewarn "USE=buffy-size is just a workaround. Disable it if you don't need it."
		myconf="${myconf} --enable-buffy-size"
	fi

	if use slang; then
		myconf="${myconf} --with-slang"
		ewarn "If you want a transparent background, merge ${PN} with USE=-slang."
	else
		# --without-slang doesn't work;
		# specify --with-curses if you don't want slang
		# (26 Sep 2001 agriffis)
		myconf="${myconf} --with-curses"
	fi

	if use mbox; then
		myconf="${myconf} --with-mailpath=/var/spool/mail"
	else
		myconf="${myconf} --with-homespool=Maildir"
	fi

	econf ${myconf}
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	find ${D}/usr/share/doc -type f | grep -v "html\|manual" | xargs gzip
	if use mbox; then
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
