# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/balsa/balsa-2.0.0_pre1.ebuild,v 1.3 2002/06/02 22:31:40 stroke Exp $

MY_V="2.0.0"
MY_P="${PN}-${MY_V}"
DATE="2002.04.24"  # Get this from the download page

S=${WORKDIR}/${MY_P}

DESCRIPTION="Balsa: Technical Preview email client for GNOME"
SRC_URI="http://balsa.gnome.org/${MY_P}.tar.bz2"
HOMEPAGE="http://balsa.gnome.org"
SLOT="0"
LICENSE="GPL-2"

RDEPEND="=dev-libs/glib-2.0*
	=x11-libs/gtk+-2.0*
	>=net-libs/libesmtp-0.8.11
	app-text/scrollkeeper
	app-text/pspell
	>=gnome-base/libgnome-1.117.2
	>=gnome-base/libgnomeui-1.117.2
	>=gnome-base/gnome-vfs-1.9.16
	>=gnome-extra/libgnomeprint-1.114.0
	>=gnome-extra/libgnomeprintui-1.114.0
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )
	perl? ( >=dev-libs/libpcre-3.4 )
	gtkhtml? ( >=gnome-extra/libgtkhtml-1.99.8 )"

DEPEND="dev-util/pkgconfig
	${RDEPEND}"

	
src_unpack() {
	 unpack ${A}
	# this patch is from Riccardo Persichetti
	# (ricpersi@libero.it) to make balsa compile
	patch -p0 < ${FILESDIR}/${MY_P}-gentoo.patch || die
	
        # This patch is from me, stroke (stroke@gentoo.org)
        patch -p0 < ${FILESDIR}/${MY_P}-varmail.patch || die
}

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	use ssl && myconf="${myconf} --with-ssl"
	use gtkhtml && myconf="${myconf} --with-gtkhtml"
	use perl && myconf="${myconf} --enable-pcre"
# 	use spell && myconf="${myconf} --enable-all"

	libmutt/configure --prefix=/usr \
		--host=${CHOST} \
		--with-mailpath=/var/mail || die "configure libmutt failed"

	myconf="${myconf} --enable-threads"

	econf ${myconf} || die "configure balsa failed"
	emake || die "emake failed"
}



src_install () {
	local myinst
	myinst="gnomeconfdir=${D}/etc \
		gnomedatadir=${D}/usr/share"

	einstall ${myinst} || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README TODO
	docinto docs
	dodoc docs/*
}
