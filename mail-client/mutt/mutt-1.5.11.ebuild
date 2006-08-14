# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mutt/mutt-1.5.11.ebuild,v 1.10 2006/08/14 17:48:48 ferdy Exp $

inherit eutils flag-o-matic

patch_assumed_charset="patch-1.5.10.tt.assumed_charset.1.gz"
patch_compressed="patch-${PV}.rr.compressed.gz"
patch_mbox_hook="patch-1.5.6.dw.mbox-hook.1"
patch_pgp_timeout="patch-1.5.6.dw.pgp-timeout.1"
patch_imap_fcc_status="mutt-1.5.4-imap-fcc-status.patch"
patch_collapse_flagged="patch-1.5.4.lpr.collapse_flagged"
opt_patch_nntp="patch-${PV}.vvv.nntp-gentoo.bz2"

DESCRIPTION="a small but very powerful text-based mail client"
HOMEPAGE="http://www.mutt.org"
SRC_URI="ftp://ftp.mutt.org/mutt/devel/${P}.tar.gz
	!vanilla? (
		http://www.emaillab.org/${PN}/1.5.10/${patch_assumed_charset}
		http://mutt.kiev.ua/download/${P}/${patch_compressed}
		http://www.woolridge.ca/${PN}/patches/${patch_mbox_hook}
		http://www.woolridge.ca/${PN}/patches/${patch_pgp_timeout}
		http://www.plumlocosoft.com/software/download/${patch_imap_fcc_status}
		http://debian.lpr.ch/Mutt/${patch_collapse_flagged}
		nntp? (
			http://dev.gentoo.org/~ferdy/distfiles/${opt_patch_nntp}
			mirror://gentoo/mutt-1.5.7-mixmaster+nntp.patch
		)
	)"
IUSE="berkdb buffysize cjk crypt debug gdbm gnutls gpgme idn imap mbox nls nntp pop sasl smime ssl vanilla"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc-macos ppc64 sparc x86"
RDEPEND="nls? ( sys-devel/gettext )
	>=sys-libs/ncurses-5.2
	gdbm?    ( sys-libs/gdbm )
	!gdbm?   ( berkdb? ( >=sys-libs/db-4 ) )
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
	idn?     ( net-dns/libidn )
	gpgme?   ( >=app-crypt/gpgme-0.9.0 )
	smime?   ( >=dev-libs/openssl-0.9.6 )
	app-misc/mime-types"
DEPEND="${RDEPEND}
	net-mail/mailbase
	~sys-devel/autoconf-2.59
	!vanilla? ( sys-devel/automake )"

pkg_setup() {
	if ! use imap; then
		echo
		einfo "The USE variable 'imap' is not in your USE flags."
		einfo "For imap support in mutt, you will need to restart the build with USE=imap"
		echo
	fi
}

src_unpack() {
	unpack ${P}.tar.gz && cd ${S} || die "unpack failed"

	# Fix configure.in sasl checking
	epatch "${FILESDIR}/${P}-sasl.patch"

	if ! use vanilla ; then
		for p in ${!patch_*} ; do
			epatch ${DISTDIR}/${!p}
		done

		if use nntp; then
			epatch ${DISTDIR}/${opt_patch_nntp}
			# Allow mutt to build with mixmaster and nntp both enabled
			epatch ${DISTDIR}/mutt-1.5.7-mixmaster+nntp.patch
		fi

		rm -rf configure autom4te.cache
		aclocal -I m4					|| die "aclocal failed"
		autoheader						|| die "autoheader failed"
		emake -C m4 -f Makefile.am.in	|| die "emake in m4 failed"
		automake --foreign				|| die "automake failed"
	fi

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
		$(use_with idn) \
		--with-curses \
		--sysconfdir=/etc/${PN} \
		--with-docdir=/usr/share/doc/${PN}-${PVR} \
		--with-regex \
		--disable-fcntl --enable-flock \
		--enable-nfs-fix --enable-external-dotlock \
		--with-mixmaster"

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
		myconf="${myconf} $(use_with sasl)"
	else
		myconf="${myconf} --without-gnutls --without-ssl --without-sasl"
	fi

	# See Bug #11170
	case ${ARCH} in
		alpha|ppc) replace-flags "-O[3-9]" "-O2" ;;
	esac

	if use buffysize; then
		ewarn "USE=buffy-size is just a workaround. Disable it if you don't need it."
		myconf="${myconf} --enable-buffy-size"
	fi

	if use mbox; then
		myconf="${myconf} --with-mailpath=/var/spool/mail"
	else
		myconf="${myconf} --with-homespool=Maildir"
	fi

	if ! use vanilla; then
		# rr.compressed patch
		myconf="${myconf} --enable-compressed"

		# nntp patch
		myconf="${myconf} $(use_enable nntp)"
	fi

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
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

	# A newer file is provided by app-misc/mime-types. So we link it.
	rm ${D}/etc/${PN}/mime.types
	dosym /etc/mime.types /etc/${PN}/mime.types

	dodoc BEWARE COPYRIGHT ChangeLog NEWS OPS* PATCHES README* TODO VERSION
}

pkg_postinst() {
	echo
	einfo "If you are new to mutt you may want to take a look at"
	einfo "the Gentoo QuickStart Guide to Mutt E-Mail:"
	einfo "   http://www.gentoo.org/doc/en/guide-to-mutt.xml"
	echo
}
