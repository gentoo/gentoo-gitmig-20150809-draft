# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/mutt/mutt-1.4-r2.ebuild,v 1.1 2002/07/28 13:05:09 stubear Exp $

S=$WORKDIR/${P}
DESCRIPTION="a small but very powerful text-based mail client"
SRC_URI="ftp://ftp.mutt.org/pub/mutt/mutt-${PV}i.tar.gz
	cjk?( http://www.emaillab.org/mutt/1.4/mutt-${PV}i-ja.1.tar.gz )" 
HOMEPAGE="http://www.mutt.org"

DEPEND=">=sys-libs/ncurses-5.2
	ssl? ( >=dev-libs/openssl-0.9.6 )
	slang? ( >=sys-libs/slang-1.4.2 )"

RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() { 
	unpack ${P}i.tar.gz 
	if [ "`use cjk`" ]; then
		unpack ${P}i-ja.1.tar.gz  
  		cd ${S} 
		patch -p1 < ../mutt-1.4i-ja.1/patch-1.4.tt.ja.1 || die 
	fi
}

src_compile() {
	local myconf
	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"

	use ssl \
		&& myconf="${myconf} --with-ssl" \
		|| myconf="${myconf} --without-ssl"

	# --without-slang doesn't work;
	# specify --with-curses if you don't want slang
	# (26 Sep 2001 agriffis)

	use slang \
		&& myconf="${myconf} --with-slang" \
		|| myconf="${myconf} --with-curses"

	use cjk && myconf="$myconf --enable-default-japanese"

	econf \
		--sysconfdir=/etc/mutt \
		--with-docdir=/usr/share/doc/mutt-$PVR \
		--with-regex --enable-pop --enable-imap --enable-nfs-fix \
		--disable-fcntl --enable-flock --enable-external-dotlock \
		--with-homespool=Maildir \
		--enable-compressed \
		${myconf} || die
	
	cp doc/Makefile doc/Makefile.orig
	sed 's/README.UPGRADE//' doc/Makefile.orig > doc/Makefile
	make || die "make failed (myconf=${myconf})"
}

src_install () {
	make DESTDIR=$D install || die
	find $D/usr/share/doc -type f |grep -v html | xargs gzip
	insinto /etc/mutt
	doins $FILESDIR/Muttrc

	dodoc BEWARE COPYRIGHT ChangeLog NEWS OPS* PATCHES README* TODO VERSION
}
