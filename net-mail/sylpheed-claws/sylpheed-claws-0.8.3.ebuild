# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/sylpheed-claws/sylpheed-claws-0.8.3.ebuild,v 1.7 2003/04/22 23:31:19 vladimir Exp $

IUSE="nls gnome xface gtkhtml crypt spell imlib ssl ldap ipv6 pda"


MY_P="sylpheed-${PV}claws"
S=${WORKDIR}/${MY_P}
S2=${WORKDIR}/gentoo-extra
DESCRIPTION="Bleeding edge version of Sylpheed"
SRC_URI="mirror://sourceforge/sylpheed-claws/${MY_P}.tar.bz2
	mirror://gentoo/sylpheed-gentoo-extra.tar.bz2"
HOMEPAGE="http://sylpheed-claws.sf.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="=x11-libs/gtk+-1.2*
	pda? ( >=app-misc/jpilot-0.99 )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	ldap? ( >=net-nds/openldap-2.0.7 )
	crypt? ( >=app-crypt/gpgme-0.3.14 )
	gnome? ( >=media-libs/gdk-pixbuf-0.16 )
	imlib? ( >=media-libs/imlib-1.9.10 )
	spell? ( virtual/aspell-dict )
	xface? ( >=media-libs/compface-1.4 )
	gtkhtml? ( net-www/dillo )"
	
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

PROVIDE="virtual/sylpheed"

src_unpack() {

	unpack ${A}

	# This patch allows for dillo web browser to be embeedded
	if use gtkhtml
	then
		cd ${S}
		patch -p1 < ${S2}/${PN}-0.8.1-gentoo.patch || die
	fi
}

src_compile() {
	local myconf

	use ssl && myconf="${myconf} --enable-ssl"

	use crypt && myconf="${myconf} --enable-gpgme"

	use gnome && \
		myconf="${myconf} --enable-gdk-pixbuf" || \
		myconf="${myconf} --disable-gdk-pixbuf"

	use imlib && \
		myconf="${myconf} --enable-imlib" || \
		myconf="${myconf} --disable-imlib"
	
	use ldap && myconf="${myconf} --enable-ldap"
	
	use spell \
		&& myconf="${myconf} --enable-aspell" \
		|| myconf="${myconf} --disable-aspell"
	
	use ipv6 && myconf="${myconf} --enable-ipv6"

	use pda && myconf="${myconf} --enable-jpilot"

	use nls || myconf="${myconf} --disable-nls"

	econf \
		--program-suffix=-claws \
		${myconf} || die "./configure failed"

	for i in `find . -name Makefile` ; do
		cp $i ${i}.orig
		sed "s/PACKAGE = sylpheed/PACKAGE = sylpheed-claws/" \
			< ${i}.orig \
			> ${i}
	done
	cp sylpheed.desktop sylpheed.desktop.orig
	sed "s/sylpheed.png/sylpheed-claws.png/" \
		< sylpheed.desktop.orig
		> sylpheed.desktop

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	
	use gnome || rm -rf ${D}/usr/share/gnome

	mv ${D}/usr/share/pixmaps/sylpheed.png \
		${D}/usr/share/pixmaps/sylpheed-claws.png
}
