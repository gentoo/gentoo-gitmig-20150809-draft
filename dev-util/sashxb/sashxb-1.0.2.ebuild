# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sashxb/sashxb-1.0.2.ebuild,v 1.11 2005/03/23 16:16:47 seemant Exp $

DESCRIPTION="Application environment for HTML and JS developers."
HOMEPAGE="http://oss.software.ibm.com/developerworks/opensource/sashxb/"
SRC_URI="http://oss.software.ibm.com/developerworks/opensource/sashxb/download/runtime/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc "
IUSE=""

RDEPEND=">=www-client/mozilla-1.0
	>=dev-libs/gdome2-0.7
	dev-libs/libxml2
	gnome-base/libglade
	=gnome-base/orbit-0*
	sys-fs/e2fsprogs
	media-libs/gdk-pixbuf
	gnome-base/gnome-core
	gnome-base/gnome-libs"

DEPEND="${RDEPEND}
	sys-devel/gettext"

src_compile() {
	patch -p1 -i ${FILESDIR}/${P}-mozilla.patch

	econf \
		--with-mozilla-lib=/usr/lib/mozilla \
		--with-mozilla-include=/usr/include/mozilla \
		--with-mozilla-idl=/usr/lib/mozilla/include/idl \
		|| die "configure problem"

	emake || die "compile problem"
}

src_install () {
	make DESTDIR=${D} install || die "install problem"

	dodoc COPYING README TODO
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
