# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/balsa/balsa-2.0.1-r1.ebuild,v 1.2 2002/07/17 04:20:39 seemant Exp $

inherit debug 

S=${WORKDIR}/${P}

DESCRIPTION="Balsa: Technical Preview email client for GNOME"
SRC_URI="http://balsa.gnome.org/${P}.tar.bz2"
HOMEPAGE="http://balsa.gnome.org"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=net-libs/libesmtp-0.8.11
	app-text/scrollkeeper
	app-text/pspell
	>=gnome-base/libgnome-2.0.1
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/gnome-vfs-2.0.1
	>=gnome-base/libgnomeprint-1.115.0
	>=gnome-base/libgnomeprintui-1.115.0
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )
	perl? ( >=dev-libs/libpcre-3.4 )
	gtkhtml? ( >=gnome-extra/libgtkhtml-2.0.0 )"

DEPEND="dev-util/pkgconfig
	${RDEPEND}"

	
src_unpack() {
	unpack ${A}
	# this patch is from Riccardo Persichetti
	# (ricpersi@libero.it) to make balsa compile
	patch -p0 < ${FILESDIR}/${P}-gentoo.patch || die


	# Workaround for bug #4095, replaces the varmail patch.
	# by Gabriele Giorgetti <stroke@gentoo.org>
	#
	# WARNING: this works for the current (2.0.1) balsa 
	# version ONLY.
        cd ${S}/libmutt
	cp configure configure.orig
	# skipping some libmutt configure checkings 
	echo -n "Applying bug #4095 workaround for balsa 2.0.1 ... " 
	sed -e "6439,6586d" configure.orig > configure
	echo " done."
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
