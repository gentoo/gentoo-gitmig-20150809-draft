# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-2.10.2.ebuild,v 1.3 2006/04/23 07:30:29 flameeyes Exp $

inherit gnome.org libtool eutils flag-o-matic debug

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://www.gtk.org/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sparc ~x86"
IUSE="debug doc hardened"

RDEPEND="virtual/libc
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
		epatch "${FILESDIR}"/glib-2.6.3-testglib-ssp.patch
	fi

	epatch ${FILESDIR}/${PN}-2.8.3-macos.patch

}

src_compile() {

	epunt_cxx
	elibtoolize

	local myconf

	# Building with --disable-debug highly unrecommended.  It will build glib in
	# an unusable form as it disables some commonly used API.  Please do not
	# convert this to the use_enable form, as it results in a broken build.
	# -- compnerd (3/27/06)
	use debug && myconf="--enable-debug"

	econf \
		$(use_enable doc gtk-doc) \
		${myconf} \
		--with-threads=posix || die "configure failed"

	emake || die "make failed"

}

src_install() {

	make DESTDIR="${D}" install || die "Installation failed"

	# Do not install charset.alias even if generated, leave it tol libiconv
	rm -f ${D}/usr/lib/charset.alias

	# Consider invalid UTF-8 filenames as locale-specific.
	# TODO :: Eventually get rid of G_BROKEN_FILENAMES
	dodir /etc/env.d
	echo "G_BROKEN_FILENAMES=1" > ${D}/etc/env.d/50glib2
	echo "G_FILENAME_ENCODING=UTF-8" >> ${D}/etc/env.d/50glib2

	dodoc AUTHORS ChangeLog* NEWS* README

}
