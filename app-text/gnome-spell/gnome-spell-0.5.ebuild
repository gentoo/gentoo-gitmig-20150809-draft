# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnome-spell/gnome-spell-0.5.ebuild,v 1.13 2003/05/16 00:58:43 pylon Exp $

IUSE="nls"

inherit gnome.org libtool

S="${WORKDIR}/${P}"
DESCRIPTION="Gnome spellchecking component."
HOMEPAGE="http://www.gnome.org/"

KEYWORDS="x86 sparc ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=net-mail/evolution-1.2.0
	>=gnome-base/gnome-libs-1.4.1.7
	=gnome-base/control-center-1.4*
	>=gnome-base/bonobo-1.0.19-r1
	<gnome-base/libglade-2.0.0
	>=gnome-extra/gal-0.19
	virtual/aspell-dict
	nls? ( sys-devel/gettext )"

src_compile() {

	elibtoolize

	local myconf=""
	use nls || myconf="${myconf} --disable-nls"

	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		${myconf} || die

	emake || die
}

src_install() {

	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		localstatedir=${D}/var/lib \
		install || die

	# Dual gnomecc entry.
	rm -f ${D}/usr/share/control-center/capplets/${PN}-properties.desktop

	dodoc AUTHORS COPYING ChangeLog NEWS README
}

