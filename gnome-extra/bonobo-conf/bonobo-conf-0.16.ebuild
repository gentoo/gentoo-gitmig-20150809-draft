# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/bonobo-conf/bonobo-conf-0.16.ebuild,v 1.2 2002/10/04 05:36:24 vapier Exp $

GNOME_TARBALL_SUFFIX="gz"
inherit gnome.org libtool

S=${WORKDIR}/${P}
DESCRIPTION="Bonobo Configuration System"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND="=dev-libs/glib-1.2*
	 =x11-libs/gtk+-1.2*
	 >=gnome-base/bonobo-1.0.15
	 >=gnome-base/oaf-0.6.6-r1"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-util/intltool-0.11"

src_compile() {
	elibtoolize

	local myconf=""
	use nls || myconf="--disable-nls"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		--disable-more-warnings \
		${myconf} || die

	make || die
}

src_install() {
	make prefix=${D}/usr \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib \
	     install || die

	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}

