# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/pango/pango-1.6.0.ebuild,v 1.4 2004/11/12 01:56:28 gustavoz Exp $

inherit gnome2 eutils

DESCRIPTION="Text rendering and layout library"
HOMEPAGE="http://www.pango.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.6/${P}.tar.bz2"

LICENSE="LGPL-2 FTL"
SLOT="0"
KEYWORDS="x86 ppc sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64"
IUSE="doc"

RDEPEND="virtual/x11
	virtual/xft
	>=dev-libs/glib-2.4
	>=media-libs/fontconfig-1.0.1
	>=media-libs/freetype-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

src_unpack() {

	unpack ${A}

	cd ${S}
	# Some enhancements from Redhat
	epatch ${FILESDIR}/pango-1.0.99.020606-xfonts.patch
	epatch ${FILESDIR}/${PN}-1.2.2-slighthint.patch

	cd ${S}/pango
	# Fix cjk issue (http://mail.gnome.org/archives/desktop-devel-list/2004-September/msg00160.html)
	epatch ${FILESDIR}/${P}-cjk_space_as_char.patch

	# make config file location host specific so that a 32bit and 64bit pango
	# wont fight with each other on a multilib system
	use amd64 && epatch ${FILESDIR}/pango-1.2.5-lib64.patch
	# and this line is just here to make building emul-linux-x86-gtklibs a bit
	# easier, so even this should be amd64 specific.
	use x86 && [ "${CONF_LIBDIR}" == "lib32" ] && epatch ${FILESDIR}/pango-1.2.5-lib64.patch

}

DOCS="AUTHORS ChangeLog README INSTALL NEWS TODO*"

src_install() {

	gnome2_src_install

	rm ${D}/etc/pango/pango.modules
	use amd64 && mkdir ${D}/etc/pango/${CHOST}
	use x86 && [ "${CONF_LIBDIR}" == "lib32" ] && mkdir ${D}/etc/pango/${CHOST}

}

pkg_postinst() {

	if [ "${ROOT}" == "/" ] ; then
		einfo "Generating modules listing..."
		use amd64 && PANGO_CONFDIR="/etc/pango/${CHOST}"
		use x86 && [ "${CONF_LIBDIR}" == "lib32" ] && PANGO_CONFDIR="/etc/pango/${CHOST}"
		PANGO_CONFDIR=${PANGO_CONFDIR:=/etc/pango/}
		pango-querymodules > /${PANGO_CONFDIR}/pango.modules
	fi

}

USE_DESTDIR="1"
