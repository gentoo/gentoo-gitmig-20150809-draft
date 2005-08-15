# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mutt/mutt-1.5.9.ebuild,v 1.7 2005/08/15 18:30:55 agriffis Exp $

inherit eutils flag-o-matic

edit_threads_patch="patch-1.5.5.1.cd.edit_threads.9.5-gentoo-r2.bz2"
compressed_patch="patch-${PV}.rr.compressed.gz"
nntp_patch="patch-${PV}.vvv.nntp-gentoo.bz2"
mbox_hook_patch="patch-1.5.6.dw.mbox-hook.1"
header_cache_patch="mutt-cvs-header-cache.29"
pgp_timeout_patch="patch-1.5.6.dw.pgp-timeout.1"
assumed_charset_patch="patch-1.5.6.tt.assumed_charset.1.gz"

DESCRIPTION="a small but very powerful text-based mail client"
HOMEPAGE="http://www.mutt.org"
SRC_URI="ftp://ftp.mutt.org/mutt/devel/mutt-${PV}i.tar.gz
	!vanilla? (
		http://dev.gentoo.org/~agriffis/dist/${edit_threads_patch}
		http://www.emaillab.org/mutt/1.5/${assumed_charset_patch}
		http://mutt.kiev.ua/download/${P}/${compressed_patch}
		http://www.woolridge.ca/mutt/patches/${mbox_hook_patch}
		nntp? (
			http://dev.gentoo.org/~agriffis/dist/${nntp_patch}
			mirror://gentoo/mutt-1.5.7-mixmaster+nntp.patch
		)
		http://wwwcip.informatik.uni-erlangen.de/~sithglan/mutt/${header_cache_patch}
		http://www.woolridge.ca/mutt/patches/${pgp_timeout_patch}
	)"
#	http://cedricduval.free.fr/mutt/patches/download/${edit_threads_patch}
#	http://www.mutt.org.ua/download/${P}/${nntp_patch}
IUSE="berkdb buffysize cjk crypt debug gdbm gnutls gpgme imap mbox nls nntp pop sasl slang smime ssl vanilla"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~ia64 ~amd64 ~mips ~ppc64 ~ppc-macos"
RDEPEND="nls? ( sys-devel/gettext )
	>=sys-libs/ncurses-5.2
	gdbm?    ( sys-libs/gdbm )
	!gdbm?   ( berkdb? ( >=sys-libs/db-4 ) )
	slang?   ( >=sys-libs/slang-1.4.2 )
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
	net-mail/mailbase
	sys-devel/autoconf
	!vanilla? ( sys-devel/automake )"

pkg_setup() {
	if ! use imap; then
		echo
		einfo "NOTE: The USE variable 'imap' is not in your USE flags."
		einfo "For imap support in mutt, you will need to restart the build with USE=imap"
		echo
	fi
}

src_unpack() {
	unpack ${P}i.tar.gz && cd ${S} || die "unpack failed"

	# fix sasl support in configure.in
	epatch ${FILESDIR}/mutt-1.5.9-sasl.patch

	# disable sgml conversion since it fails with sgml2html
	epatch ${FILESDIR}/mutt-1.5.9-nodoc.patch

	if ! use vanilla; then
		epatch ${DISTDIR}/${compressed_patch}
		epatch ${DISTDIR}/${edit_threads_patch}
		epatch ${DISTDIR}/${mbox_hook_patch}
		epatch ${DISTDIR}/${header_cache_patch}
		epatch ${DISTDIR}/${pgp_timeout_patch}
		epatch ${DISTDIR}/${assumed_charset_patch}
		if use nntp; then
			epatch ${DISTDIR}/${nntp_patch}
			# Allow mutt to build with mixmaster and nntp both enabled
			epatch ${DISTDIR}/mutt-1.5.7-mixmaster+nntp.patch
		fi

		aclocal -I m4					|| die "aclocal failed"
		autoheader						|| die "autoheader failed"
		emake -C m4 -f Makefile.am.in	|| die "emake in m4 failed"
		automake --foreign				|| die "automake failed"
	fi

	WANT_AUTOCONF=2.13 autoconf		|| die "autoconf failed"
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
		--enable-compressed \
		--sysconfdir=/etc/${PN} \
		--with-docdir=/usr/share/doc/${PN}-${PVR} \
		--with-regex \
		--disable-fcntl --enable-flock --enable-nfs-fix \
		--with-mixmaster \
		--without-sasl \
		--enable-external-dotlock"

	# See Bug #22787
	unset WANT_AUTOCONF_2_5 WANT_AUTOCONF

	# mutt prioritizes gdbm over bdb, so we will too.
	# hcache feature requires at least one database is in USE.
	if use gdbm; then
		myconf="${myconf} --enable-hcache --with-gdbm --without-bdb"
	elif use berkdb; then
		myconf="${myconf} --enable-hcache --with-bdb --without-gdbm"
	else
		myconf="${myconf} --disable-hcache --without-gdbm --without-bdb"
	fi

	# there's no need for gnutls, ssl or sasl without either pop or imap.
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

	if ! use vanilla; then
		# imap part of edit_threads patch
		myconf="${myconf} $(use_enable imap imap-edit-threads)"

		# rr.compressed patch
		myconf="${myconf} --enable-compressed"

		# nntp patch
		myconf="${myconf} $(use_enable nntp)"
	fi

	econf ${myconf}
	emake || die "emake failed (myconf=${myconf})"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	find ${D}/usr/share/doc -type f | grep -v "html\|manual" | xargs gzip
	if use mbox; then
		insinto /etc/mutt
		newins ${FILESDIR}/Muttrc.mbox Muttrc
	else
		insinto /etc/mutt
		doins ${FILESDIR}/Muttrc
	fi

	dodoc BEWARE COPYRIGHT ChangeLog NEWS OPS* PATCHES README* TODO VERSION
}

pkg_postinst() {
	echo
	einfo "For information about using mutt, please refer to:"
	einfo "  http://www.gentoo.org/doc/en/guide-to-mutt.xml"
	echo
}
