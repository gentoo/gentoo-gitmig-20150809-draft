# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/sylpheed-claws/sylpheed-claws-0.8.10.ebuild,v 1.2 2003/04/22 23:31:19 vladimir Exp $

IUSE="nls gnome xface gtkhtml crypt spell imlib ssl ldap ipv6 pda"

inherit eutils

MY_P="sylpheed-${PV}claws"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Bleeding edge version of Sylpheed"
SRC_URI="mirror://sourceforge/sylpheed-claws/${MY_P}.tar.bz2"
HOMEPAGE="http://sylpheed-claws.sf.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa"

DEPEND="=x11-libs/gtk+-1.2*
	pda? ( >=app-misc/jpilot-0.99 )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	ldap? ( >=net-nds/openldap-2.0.7 )
	crypt? ( =app-crypt/gpgme-0.3.14 )
	gnome? ( >=media-libs/gdk-pixbuf-0.16 )
	imlib? ( >=media-libs/imlib-1.9.10 )
	spell? ( virtual/aspell-dict )
	xface? ( >=media-libs/compface-1.4 )
	gtkhtml? ( net-www/dillo )
	x11-misc/shared-mime-info"
	
RDEPEND="nls? ( sys-devel/gettext )"

PROVIDE="virtual/sylpheed"

src_unpack() {
	unpack ${A}

	# This patch allows for dillo web browser to be embeedded
	if use gtkhtml
	then
		cd ${S}
		epatch ${FILESDIR}/sylpheed-0.8.3claws32-dillo.patch
	fi

	# Change package name to sylpheed-claws ...
	for i in `find ${S}/ -name 'configure*'`
	do
		cp $i ${i}.orig
		sed -e "s/PACKAGE\=sylpheed/PACKAGE\=sylpheed-claws/" \
			${i}.orig > ${i}
	done
	
	# use shared-mime-info
	cd ${S}/src
	epatch ${FILESDIR}/procmime.patch
}

src_compile() {
	local myconf

	use gnome \
	    && myconf="${myconf} --enable-gdk-pixbuf" \
	    || myconf="${myconf} --disable-gdk-pixbuf"
	
	use imlib \
	    && myconf="${myconf} --enable-imlib" \
	    || myconf="${myconf} --disable-imlib"
	    
	use spell \
	    && myconf="${myconf} --enable-aspell" \
	    || myconf="${myconf} --disable-aspell"
	    
	use ldap && myconf="${myconf} --enable-ldap"
	
	use ssl && myconf="${myconf} --enable-openssl"
	
	use crypt && myconf="${myconf} --enable-gpgme"
	
	use ipv6 && myconf="${myconf} --enable-ipv6"
	
	use pda && myconf="${myconf} --enable-jpilot"
	
	use nls || myconf="${myconf} --disable-nls"
	
	echo ${myconf}
	
	econf \
		--program-suffix=-claws \
		--enable-spamassassin-plugin \
		${myconf} || die "./configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	local menuentry="/usr/share/gnome/apps/Internet/sylpheed.desktop"
	use gnome \
		&& {
			dosed "s/Sylpheed/Sylpheed Claws/" ${menuentry}
			dosed "s/sylpheed/sylpheed-claws/" ${menuentry}
			mv ${D}${menuentry} ${D}${menuentry/sylpheed/sylpheed-claws}
		} \
		|| rm -rf ${D}/usr/share/gnome

	mv ${D}/usr/share/pixmaps/sylpheed.png \
		${D}/usr/share/pixmaps/sylpheed-claws.png

	dodoc AUTHORS ChangeLog* INSTALL* NEWS README* TODO*  
}

pkg_postinst() {
	einfo "A new plugin scheme has been implemented and a spamassassin plugin"
	einfo "now comes with sylpheed-claws. For info on these please read the"
	einfo "Changelog"
}
