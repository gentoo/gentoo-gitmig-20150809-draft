# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mutt/mutt-1.5.4-r1.ebuild,v 1.1 2003/05/29 07:59:02 utx Exp $

IUSE="ssl nls slang cjk crypt imap mbox"

inherit eutils

edit_threads="patch-1.5.3.cd.edit_threads.9.5"

S=$WORKDIR/${P}
DESCRIPTION="a small but very powerful text-based mail client"
SRC_URI="ftp://ftp.mutt.org/mutt/devel/mutt-${PV}i.tar.gz
	http://www.spinnaker.de/mutt/compressed/patch-${PV}.rr.compressed.1.gz
	cjk? ( http://www.emaillab.org/mutt/1.5/${P}i-ja.1.tar.gz )
	http://cedricduval.free.fr/download/mutt/${edit_threads}"
HOMEPAGE="http://www.mutt.org"

DEPEND=">=sys-libs/ncurses-5.2
	ssl? ( >=dev-libs/openssl-0.9.6 )
	slang? ( >=sys-libs/slang-1.4.2 )"

RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"

inherit flag-o-matic

src_unpack() {
	unpack ${P}i.tar.gz

	cd ${S}
	epatch ${DISTDIR}/patch-${PV}.rr.compressed.1.gz
	epatch ${DISTDIR}/${edit_threads}

	if [ "`use cjk`" ]; then
		cd ${WORKDIR}
		unpack ${P}i-ja.1.tar.gz
		cd ${S}
		epatch ../${P}i-ja.1/patch-${PV}.tt.ja.1
	fi
}

src_compile() {
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
	find $D/usr/share/doc -type f |grep -v html | xargs gzip
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
	einfo "To enable imap support in mutt, make sure you have 'imap' set."
}
