# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mutt/mutt-1.5.5.1.ebuild,v 1.5 2004/02/17 15:37:20 agriffis Exp $

IUSE="ssl nls slang crypt imap mbox"

inherit eutils

edit_threads_patch="patch-1.5.3.cd.edit_threads.9.5"
compressed_patch="patch-${PV}.rr.compressed.1.gz"

DESCRIPTION="a small but very powerful text-based mail client"
HOMEPAGE="http://www.mutt.org"
SRC_URI="ftp://ftp.mutt.org/mutt/devel/mutt-${PV}i.tar.gz
	http://cedricduval.free.fr/mutt/patches/download/${edit_threads_patch}
	http://www.spinnaker.de/mutt/compressed/${compressed_patch}"

RDEPEND="nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	>=sys-libs/ncurses-5.2
	ssl? ( >=dev-libs/openssl-0.9.6 )
	slang? ( >=sys-libs/slang-1.4.2 )
	>=sys-apps/sed-4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~ia64 ~amd64"

inherit flag-o-matic

pkg_setup() {
	if ! use imap; then
		echo
		einfo
		einfo "NOTE: The USE variable 'imap' is not in your USE flags."
		einfo "For imap support in mutt, you will need to restart the build with USE=imap"
		echo
	fi
}

src_unpack() {
	unpack ${P}i.tar.gz

	cd ${S}
	epatch ${DISTDIR}/patch-${PV}.rr.compressed.1.gz
	epatch ${DISTDIR}/${edit_threads_patch}

}

src_compile() {
	# See Bug #22787
	unset WANT_AUTOCONF_2_5
	# See Bug #11170
	case ${ARCH} in
		alpha|ppc) replace-flags "-O[3-9]" "-O2" ;;
	esac

	local myconf
	myconf="`use_enable nls` `use_with ssl` \
			`use_enable imap` `use_enable crypt pgp`"

	# --without-slang doesn't work;
	# specify --with-curses if you don't want slang
	# (26 Sep 2001 agriffis)

	use slang \
		&& myconf="${myconf} --with-slang" \
		&& ewarn "If you want transparent background, please merge mutt with USE=-slang." \
		|| myconf="${myconf} --with-curses"

	use mbox \
		&& myconf="${myconf} --with-maildir=/var/spool/mail" \
		|| myconf="${myconf} --with-homespool=Maildir"

	use cjk && myconf="$myconf --enable-default-japanese"

	econf \
		--sysconfdir=/etc/mutt \
		--with-docdir=/usr/share/doc/mutt-$PVR \
		--with-regex --enable-pop --enable-nfs-fix \
		--disable-fcntl --enable-flock --enable-external-dotlock \
		--enable-compressed \
		--enable-imap-edit-threads \
		${myconf} || die

	mv doc/Makefile doc/Makefile.orig
	sed 's/README.UPGRADE//' doc/Makefile.orig > doc/Makefile
	make || die "make failed (myconf=${myconf})"
}

src_install() {
	make DESTDIR=$D install || die
	find $D/usr/share/doc -type f |grep -v "html\|manual" | xargs gzip
	insinto /etc/mutt
	if [ "`use mbox`" ]; then
		einfo "Not installing an /etc/Muttrc as mbox is default configuration"
		einfo "with mutt"
	else
		doins $FILESDIR/Muttrc
	fi

	dodoc BEWARE COPYRIGHT ChangeLog NEWS OPS* PATCHES README* TODO VERSION
}

pkg_postinst() {
	einfo "The USE variable 'imap' is not set by default on most architectures."
	einfo "To enable imap support in mutt, make sure you have USE=imap"
}
