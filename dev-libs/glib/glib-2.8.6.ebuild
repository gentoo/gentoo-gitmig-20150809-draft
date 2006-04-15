# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-2.8.6.ebuild,v 1.11 2006/04/15 01:30:37 geoman Exp $

inherit gnome.org libtool eutils flag-o-matic debug

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://www.gtk.org/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~alpha amd64 arm hppa ia64 m68k mips ppc ~ppc-macos ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="debug doc hardened"

RDEPEND="virtual/libintl
	virtual/libiconv"

DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.14
		>=sys-devel/gettext-0.11
		doc?	(
					>=dev-util/gtk-doc-1.4
					~app-text/docbook-xml-dtd-4.1.2
				)"


src_unpack() {
	unpack ${A}
	cd ${S}

	if use ppc64 && use hardened; then
		replace-flags -O[2-3] -O1
		epatch ${FILESDIR}/glib-2.6.3-testglib-ssp.patch
	fi

	epatch ${FILESDIR}/${PN}-2.8.3-macos.patch
}

src_compile() {
	epunt_cxx
	elibtoolize

	local myconf="--with-threads=posix $(use_enable doc gtk-doc)"

	# --disable-debug is not recommended for production use
	use debug && myconf="${myconf} --enable-debug=yes"

	econf $myconf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	# Do not install charset.alias for ppc-macos since it already exists.
	if use ppc-macos ; then
		einfo "Not installing charset.alias on macos"
		rm ${D}/usr/lib/charset.alias || die "Cannot remove charset.alias from the image"
	fi

	# Consider invalid UTF-8 filenames as locale-specific.
	# FIXME : we should probably move to suggesting G_FILENAME_ENC
	dodir /etc/env.d
	echo "G_BROKEN_FILENAMES=1" > ${D}/etc/env.d/50glib2

	dodoc AUTHORS ChangeLog* NEWS* README
}
