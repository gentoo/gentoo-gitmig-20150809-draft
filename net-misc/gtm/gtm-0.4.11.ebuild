# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtm/gtm-0.4.11.ebuild,v 1.11 2003/09/05 22:01:48 msterret Exp $

IUSE="ssl nls gnome"

S=${WORKDIR}/${P}
DESCRIPTION="GTM - a transfer manager"
SRC_URI="http://download.sourceforge.net/gtm/${P}.tar.gz"
HOMEPAGE="http://gtm.sourceforge.net/"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	virtual/x11
	x11-libs/gtk+
	gnome-base/oaf
	gnome-base/gnome-core
	gnome-base/gnome-libs
	gnome? ( gnome-base/gnome-applets )
	ssl?   ( dev-libs/openssl )"

RDEPEND="virtual/glibc
	virtual/x11
	net-misc/wget
	>=gnome-base/gnome-libs-1.4.0.2
	>=gnome-base/ORBit-0.5.11"


src_unpack() {

	unpack ${A}

	for lang in C pt
	do
		cp ${S}/doc/${lang}/Makefile.in ${S}/doc/${lang}/Makefile.in.orig
		sed -e 's: \$(gtm_helpdir): \$(DESTDIR)$(gtm_helpdir):g' \
			${S}/doc/${lang}/Makefile.in.orig \
			>${S}/doc/${lang}/Makefile.in
	done

}

src_compile() {

	local myconf
	use nls   || myconf="--disable-nls"
	use gnome || myconf="${myconf} --disable-applet"
	use gnome && myconf="${myconf} --enable-applet"
	use ssl   || myconf="${myconf} --disable-ssl"
	use ssl   && myconf="${myconf} --enable-ssl"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--localstatedir=/var/lib \
		--sysconfdir=/etc \
		--without-debug \
		$myconf || die

	emake || die
}

src_install() {

	make DESTDIR=${D} install || die
}

