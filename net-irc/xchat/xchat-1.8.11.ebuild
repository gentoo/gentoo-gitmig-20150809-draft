# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-1.8.11.ebuild,v 1.11 2004/01/04 01:34:08 pyrania Exp $

inherit eutils

IUSE="ssl nls mmx gnome ipv6 python kde gtk perl"

S=${WORKDIR}/${P}
DESCRIPTION="X-Chat is a graphical IRC client for UNIX operating systems."
SRC_URI="http://www.xchat.org/files/source/1.8/${P}.tar.bz2"
HOMEPAGE="http://www.xchat.org/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc alpha"

RDEPEND="gtk? ( =x11-libs/gtk+-1.2* )
	python? ( >=dev-lang/python-2.2-r7 )
	perl?   ( >=dev-lang/perl-5.6.1 )
	gnome?  ( <gnome-base/gnome-panel-1.5.0
		>=media-libs/gdk-pixbuf-0.22.0 )
	ssl?    ( >=dev-libs/openssl-0.9.6a )"

DEPEND="${RDEPEND}
	nls?    ( >=sys-devel/gettext-0.10.38 )"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/xc1811fixststint.diff

	use python && ( \
		cp configure configure.orig
		local mylibs=`/usr/bin/python-config`
		sed -e 's:PY_LIBS=".*":PY_LIBS="'"$mylibs"'":' \
			configure.orig > configure
	)
}

src_compile() {

	local myopts myflags

	if [ ! `use perl` ]; then
		use gnome \
			&& myopts="${myopts} --enable-gnome --enable-panel" \
			   CFLAGS="${CFLAGS} -I/usr/include/orbit-1.0" \
			|| myopts="${myopts} --enable-gtkfe --disable-gnome --disable-zvt --disable-gdk-pixbuf"
	else
		myopts="${myopts} --disable-gnome"
	fi

	use gtk \
		|| myopts="${myopts} --disable-gtkfe"

	use ssl \
		&& myopts="${myopts} --enable-openssl"

	use perl \
		|| myopts="${myopts} --disable-perl"

	use nls \
		&& myopts="${myopts} --enable-nls --enable-hebrew --enable-japanese-conv" \
		|| myopts="${myopts} --disable-nls --disable-hebrew --disable-japanese-conv"

	if use x86
	then
		use mmx	\
			&& myopts="${myopts} --enable-mmx"	\
			|| myopts="${myopts} --disable-mmx"
	fi

	use ipv6 \
		&& myopts="${myopts} --enable-ipv6"

	use python \
		&& myflags="`python-config`" \
	 	&& myopts="${myopts} --enable-python"


	econf ${myopts} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	use gnome && ( \
		insinto /usr/share/gnome/apps/Internet
		doins xchat.desktop
	)

	dodoc AUTHORS COPYING ChangeLog README
}
