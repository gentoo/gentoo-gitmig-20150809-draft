# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gtm/gtm-0.4.12.ebuild,v 1.8 2004/08/22 04:42:19 obz Exp $

IUSE="ssl nls gnome"

DESCRIPTION="GTM - a transfer manager"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gtm.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
	=gnome-base/gnome-panel-1.4*
	>=gnome-base/gnome-libs-1.4.1.7
	>=gnome-base/oaf-0.6.8
	=gnome-base/orbit-0*
	gnome? ( =gnome-base/gnome-applets-1.4* )
	ssl?   ( dev-libs/openssl )"

RDEPEND="${DEPEND}
	net-misc/wget"


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
