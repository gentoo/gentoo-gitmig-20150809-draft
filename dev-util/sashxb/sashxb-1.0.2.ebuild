# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/sashxb/sashxb-1.0.2.ebuild,v 1.1 2002/07/15 01:54:32 blizzy Exp $

S="${WORKDIR}/${P}"

DESCRIPTION="Application environment for HTML and JS developers."
HOMEPAGE="http://oss.software.ibm.com/developerworks/opensource/sashxb/"
SRC_URI="http://oss.software.ibm.com/developerworks/opensource/sashxb/download/runtime/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"

RDEPEND=">=virtual/glibc-2.2.3
	>=net-www/mozilla-1.0
	>=dev-libs/gdome2-0.7
	dev-libs/libxml2
	sys-devel/gettext
	gnome-base/libglade
	gnome-base/ORBit
	sys-apps/e2fsprogs
	media-libs/gdk-pixbuf
	gnome-base/gnome-core
	gnome-base/gnome-libs"
DEPEND="${RDEPEND}"

src_compile() {
	patch -p1 -i ${FILESDIR}/${P}-mozilla.patch

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--with-mozilla-lib=/usr/lib/mozilla \
		--with-mozilla-include=/usr/include/mozilla \
		--with-mozilla-idl=/usr/lib/mozilla/include/idl \
		|| die "configure problem"

	emake || die "compile problem"
}

src_install () {
	make DESTDIR=${D} install || die "install problem"

	dodoc ABOUT-NLS COPYING README TODO
}

pkg_postinst() {
	einfo "The SashXB runtime has been installed. You may want to take a"
	einfo "look at the Weblications gallery now, and install some of them"
	einfo "from your regular user account (that means, *not* as root"
	einfo "unless you know what you're doing):"
	einfo ""
	einfo "\thttp://oss.software.ibm.com/developerworks/opensource/sashxb/download/gallery.html"
	einfo ""
	einfo "For example, to install the Registry Test, type:"
	einfo
	einfo "\tsash-install regtest"
}
