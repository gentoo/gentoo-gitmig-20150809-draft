# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/balsa/balsa-2.0.1-r2.ebuild,v 1.9 2003/04/23 00:28:54 vladimir Exp $

IUSE="gtkhtml ssl nls perl"

inherit debug 

S=${WORKDIR}/${P}

DESCRIPTION="Balsa: Technical Preview email client for GNOME"
SRC_URI="http://balsa.gnome.org/${P}.tar.bz2"
HOMEPAGE="http://balsa.gnome.org"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 sparc  ppc"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=net-libs/libesmtp-0.8.11
	virtual/aspell-dict
	app-text/scrollkeeper
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


export WANT_AUTOMAKE_1_4=1

src_unpack() {
	unpack ${A}

	# this patch is from Riccardo Persichetti
	# (ricpersi@libero.it) to make balsa compile
	# <seemant@gentoo.org> this patch is updated by me to compile
	# against the new aspell (until upstream gets its act together, aspell
	# will be a required dep).
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

	autoconf || die
	automake || die

	libmutt/configure \
		--prefix=/usr \
		--host=${CHOST} \
		--with-mailpath=/var/mail || die "configure libmutt failed"

	myconf="${myconf} --enable-threads"

	econf \
		--with-aspell=yes \
		${myconf} || die "configure balsa failed"
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
