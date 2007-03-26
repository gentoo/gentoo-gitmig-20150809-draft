# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkDPS/gtkDPS-0.3.4.ebuild,v 1.24 2007/03/26 19:15:04 genstef Exp $

inherit eutils gnuconfig multilib

DESCRIPTION="Set of functions, objects and widgets to use DPS easily with GTK"
SRC_URI="ftp://ftp.gyve.org/pub/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gyve.org/gtkDPS/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1.2*
	app-text/dgs
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch
	gnuconfig_update
}

src_compile() {
	if ! use nls ; then
		myconf="--disable-nls"
	fi
	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		--with-x \
		--with-dps $myconf \
		--libdir=${D}/usr/$(get_libdir) \
		|| die
	#Very ugly workaround 
	use nls && echo '#define LOCALEDIR "/usr/share/locale"' >> config.h
	make || die
}

src_install () {
	make prefix="${D}"/usr install || die
	dodoc ChangeLog GTKDPS-VERSION HACKING NEWS README TODO
}
