# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/w3m/w3m-0.4.2.ebuild,v 1.4 2006/04/21 17:32:14 flameeyes Exp $

inherit eutils

IUSE="gpm cjk gtk imlib xface ssl"

DESCRIPTION="Text based WWW browser, supports tables and frames"
SRC_URI="mirror://sourceforge/w3m/${P}.tar.gz"
HOMEPAGE="http://w3m.sourceforge.net/"

SLOT="0"
LICENSE="w3m"
KEYWORDS="x86 alpha ppc sparc amd64"

DEPEND=">=sys-libs/ncurses-5.2-r3
	>=sys-libs/zlib-1.1.3-r2
	>=dev-libs/boehm-gc-6.2
	gtk? ( =x11-libs/gtk+-1.2*
		media-libs/gdk-pixbuf )
	!gtk? ( imlib? ( >=media-libs/imlib-1.9.8 ) )
	xface? ( media-libs/compface )
	gpm? ( >=sys-libs/gpm-1.19.3-r5 )
	ssl? ( >=dev-libs/openssl-0.9.6b )"

PROVIDE="virtual/w3m"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/w3m-w3mman-gentoo.diff
}

src_compile() {

	local myconf migemo_command

	use cjk && myconf="${myconf} --enable-japanese=E"

	if use imlib || use gtk; then
		myconf="${myconf} --enable-image=x11,fb `use_enable xface`"
	else
		myconf="${myconf} --enable-image=no"
	fi

	if has_version 'app-emacs/migemo' ; then
		migemo_command="migemo -t egrep /usr/share/migemo/migemo-dict"
	else
		migemo_command="no"
	fi

	econf --enable-keymap=w3m \
		--with-editor=/usr/bin/nano \
		--with-mailer=/bin/mail \
		--with-browser=/usr/bin/mozilla \
		--with-termlib=ncurses \
		--with-migemo="${migemo_command}" \
		`use_enable gpm mouse` \
		`use_enable ssl digest-auth` \
		`use_with ssl` \
		${myconf} || die

	make || make || die "make failed"
}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	insinto /usr/share/${PN}/Bonus
	doins Bonus/*
	dodoc README NEWS TODO ChangeLog
	docinto doc-en ; dodoc doc/*
	if use cjk ; then
		docinto doc-jp ; dodoc doc-jp/*
	else
		rm -rf ${D}/usr/share/man/ja
	fi
}
