# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header:

IUSE="ssl X gtk gnome mozilla socks5 nls"

DESCRIPTION="Web spider and website mirroring tool"
SRC_URI="http://www.pavuk.org/sw/${PN}-0.9pl28.tgz"

HOMEPAGE="http://www.pavuk.org/"

S="${WORKDIR}/${PN}-0.9pl28"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="sys-devel/gettext
	sys-libs/zlib
	ssl? ( dev-libs/openssl )
	X? ( virtual/x11 )
	gtk? ( x11-libs/gtk+ )
	gnome? ( gnome-base/gnome )
	mozilla? ( net-www/mozilla )
	socks5? ( net-misc/tsocks )"

src_unpack() {

	unpack ${A}

	cd ${S}
}

src_compile() {

	local myconf
	myconf="--enable-threads --with-regex=auto"

	use X \
		&& myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"
	
	use ssl \
		&& myconf="${myconf} --enable-ssl" \
		|| myconf="${myconf} --disable-ssl"

	use gtk \
		&& myconf="${myconf} --enable-gtk" \
		|| myconf="${myconf} --disable-gtk" 

	use gnome \
		&& myconf="${myconf} --enable-gnome" \
		|| myconf="${myconf} --disable-gnome"

	use mozilla \
		&& myconf="${myconf} --enable-js" \
		|| myconf="${myconf} --disable-js"

	use socks5 \
		&& myconf="${myconf} --enable-socks" \
		|| myconf="${myconf} --disable-socks"
	
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	econf ${myconf}

	emake || die
}

src_install() {

	# fix sandbox volation for gnome .desktop and icon
	use gnome \
		&& mv Makefile Makefile.orig \
		&& mv icons/Makefile icons/Makefile.orig \
		&& sed -e 's/GNOME_PREFIX = \/usr/GNOME_PREFIX = ${D}usr/' Makefile.orig >Makefile \
		&& sed -e 's/GNOME_PREFIX = \/usr/GNOME_PREFIX = ${D}usr/' icons/Makefile.orig >icons/Makefile

	einstall

	dodoc ABOUT-NLS README CREDITS FAQ NEWS AUTHORS COPYING BUGS \
		TODO MAILINGLIST ChangeLog wget-pavuk.HOWTO jsbind.txt \
		pavuk_authinfo.sample  pavukrc.sample
}

