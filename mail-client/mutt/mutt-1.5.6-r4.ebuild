# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mutt/mutt-1.5.6-r4.ebuild,v 1.4 2004/11/12 18:10:18 gustavoz Exp $

inherit eutils flag-o-matic
IUSE="cjk ssl nls slang crypt imap mbox nntp vanilla"

edit_threads_patch="patch-1.5.5.1.cd.edit_threads.9.5-gentoo.bz2"
compressed_patch="patch-${PV}.rr.compressed.gz"
nntp_patch="patch-${PV}.vvv.nntp-gentoo-r2.bz2"
mbox_hook_patch="patch-${PV}.dw.mbox-hook.1"
header_cache_patch="patch-${PV}.tg.hcache.8"
pgp_timeout_patch="patch-${PV}.dw.pgp-timeout.1"

DESCRIPTION="a small but very powerful text-based mail client"
HOMEPAGE="http://www.mutt.org"
SRC_URI="ftp://ftp.mutt.org/mutt/devel/mutt-${PV}i.tar.gz
	!vanilla? (
		mirror://gentoo/${edit_threads_patch}
		http://mutt.kiev.ua/download/${P}/${compressed_patch}
		http://www.woolridge.ca/mutt/patches/${mbox_hook_patch}
		nntp? ( mirror://gentoo/${nntp_patch} )
		http://wwwcip.informatik.uni-erlangen.de/~sithglan/mutt/${header_cache_patch}
		http://www.woolridge.ca/mutt/patches/${pgp_timeout_patch}
	)"
#	nntp? ( http://mutt.kiev.ua/download/${P}/${nntp_patch} )
#	http://cedricduval.free.fr/mutt/patches/download/${edit_threads_patch}

RDEPEND="nls? ( sys-devel/gettext )
	>=sys-libs/ncurses-5.2
	ssl? ( >=dev-libs/openssl-0.9.6 )
	slang? ( >=sys-libs/slang-1.4.2 )
	!vanilla? ( sys-libs/gdbm )"
DEPEND="${RDEPEND}
	net-mail/mailbase
	!vanilla? ( nntp? ( sys-devel/automake sys-devel/autoconf ) )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc alpha ~hppa ia64 amd64 ~mips ~ppc64 ~ppc-macos"


pkg_setup() {
	if ! use imap; then
		echo
		einfo
		einfo "NOTE: The USE variable 'imap' is not in your USE flags."
		einfo "For imap support in mutt, you will need to restart the build with USE=imap"
		einfo
		echo
	fi
}

src_unpack() {
	unpack ${P}i.tar.gz && cd ${S} || die "unpack failed"
	if ! use vanilla; then
		epatch ${DISTDIR}/${compressed_patch}
		epatch ${DISTDIR}/${edit_threads_patch}
		epatch ${DISTDIR}/${mbox_hook_patch}
		epatch ${DISTDIR}/${header_cache_patch}
		epatch ${DISTDIR}/${pgp_timeout_patch}
		use nntp && epatch ${DISTDIR}/${nntp_patch}

		# The following steps are necessary for the nntp patch and the
		# header_cache_patch
		aclocal -I m4					|| die "aclocal failed"
		autoheader						|| die "autoheader failed"
		make -C m4 -f Makefile.am.in	|| die "make in m4 failed"
		automake --foreign				|| die "automake failed"
		WANT_AUTOCONF=2.5 autoconf		|| die "autoconf failed"
	fi

	# Fix a slang problem that is already fixed in upstream cvs
	epatch ${FILESDIR}/slang.patch

	# Fix ability to read from a subprocess with source script.sh|
	# Bug #42738 (25 Feb 2004 agriffis)
	epatch ${FILESDIR}/8patch-1.5.6.dyc.source_stat
}

src_compile() {
	local myconf="
		$(use_enable nls) \
		$(use_with ssl) \
		$(use_enable imap) \
		$(use_enable crypt pgp) \
		$(use_enable cjk default-japanese) \
		--sysconfdir=/etc/mutt \
		--with-docdir=/usr/share/doc/mutt-${PVR} \
		--with-regex --enable-pop --enable-nfs-fix \
		--disable-fcntl --enable-flock --enable-external-dotlock"

	# See Bug #22787
	unset WANT_AUTOCONF_2_5 WANT_AUTOCONF

	# See Bug #11170
	case ${ARCH} in
		alpha|ppc) replace-flags "-O[3-9]" "-O2" ;;
	esac

	if use slang; then
		myconf="${myconf} --with-slang"
		ewarn "If you want a transparent background,"
		ewarn "please merge mutt with USE=-slang."
	else
		# --without-slang doesn't work;
		# specify --with-curses if you don't want slang
		# (26 Sep 2001 agriffis)
		myconf="${myconf} --with-curses"
	fi

	if use mbox; then
		myconf="${myconf} --with-maildir=/var/spool/mail"
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

		# maildir_header_cache_patch
		myconf="${myconf} --enable-hcache"
	fi

	econf ${myconf} || die
	make || die "make failed (myconf=${myconf})"
}

src_install() {
	make DESTDIR=${D} install || die
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
	einfo "The USE variable 'imap' is not set by default on most architectures."
	einfo "To enable imap support in mutt, make sure you have USE=imap"
}
