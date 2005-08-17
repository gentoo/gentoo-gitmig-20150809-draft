# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mutt/mutt-1.4.2.1.ebuild,v 1.9 2005/08/17 20:03:48 agriffis Exp $

IUSE="cjk imap mbox nls slang ssl vanilla"

inherit eutils flag-o-matic

edit_threads_patch="patch-1.4.0.cd.edit_threads.9.5"
compressed_patch="patch-1.4.2.rr.compressed.1-gentoo.bz2"
cjk_patch="mutt-${PV}i-ja.1.tar.gz"

DESCRIPTION="a small but very powerful text-based mail client"
HOMEPAGE="http://www.mutt.org"
SRC_URI="ftp://ftp.mutt.org/mutt/mutt-${PV}i.tar.gz
	mirror://gentoo/${compressed_patch}
	http://cedricduval.free.fr/mutt/patches/download/${edit_threads_patch}
	cjk? ( http://www.emaillab.org/mutt/1.4/${cjk_patch} )"
#	http://www.spinnaker.de/mutt/compressed/${compressed_patch}

RDEPEND="nls? ( sys-devel/gettext )
	>=sys-libs/ncurses-5.2
	ssl? ( >=dev-libs/openssl-0.9.6 )
	slang? ( >=sys-libs/slang-1.4.2 )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha hppa ~mips ppc sparc x86"

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
	if ! use vanilla; then
		epatch ${DISTDIR}/${compressed_patch}
		epatch ${DISTDIR}/${edit_threads_patch}
	fi
	if use cjk; then
		cd ${WORKDIR}
		unpack ${cjk_patch} && cd ${S} || die "unpack cjk failed"
		epatch ${WORKDIR}/${cjk_patch%.t*}/patch-${PV}.tt.ja.1
	fi
}

src_compile() {
	local myconf="
		$(use_enable nls) \
		$(use_with ssl) \
		$(use_enable imap) \
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
	fi
	econf ${myconf}
	sed -i 's/README.UPGRADE//' doc/Makefile || die "sed failed"
	make || die "make failed (myconf=${myconf})"
}

src_install () {
	make DESTDIR=${D} install || die "install failed"
	find ${D}/usr/share/doc -type f | grep -v html | xargs gzip
	if use mbox; then
		echo "Not installing an /etc/Muttrc as mbox is default configuration"
		echo "with mutt"
	else
		insinto /etc/mutt
		doins $FILESDIR/Muttrc
	fi

	dodoc BEWARE COPYRIGHT ChangeLog NEWS OPS* PATCHES README* TODO VERSION
}

pkg_postinst() {
	echo
	einfo "For information about using mutt, please refer to:"
	einfo "  http://www.gentoo.org/doc/en/guide-to-mutt.xml"
	echo
}
