# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-2.6.2-r1.ebuild,v 1.9 2005/04/07 01:58:28 dostrow Exp $

inherit libtool eutils flag-o-matic

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.6/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 mips ~ppc ppc64 ~ppc-macos s390 ~sparc x86"
IUSE="doc hardened"
DEPEND=">=dev-util/pkgconfig-0.14
	>=sys-devel/gettext-0.11
	doc? ( >=dev-util/gtk-doc-1 )"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	use ppc-macos && epatch ${FILESDIR}/${PN}-2-macos.patch
	if (use ppc64 && use hardened); then
		replace-flags -O[2-3] -O1
		epatch ${FILESDIR}/glib-2.6.3-testglib-ssp.patch
	fi
}

src_compile() {

	epunt_cxx

	if use ppc-macos; then
		glibtoolize
		append-ldflags "-L/usr/lib -lpthread"
	fi

	# enable static for PAM
	econf \
		--with-threads=posix \
		--enable-static \
		`use_enable doc gtk-doc` \
		|| die

	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	# Do not install charset.alias for ppc-macos since it already exists.
	if use ppc-macos ; then
		einfo "Not installing charset.alias on macos"
		rm ${D}/usr/lib/charset.alias || die "Cannot remove charset.alias from the image"
	fi

	# Consider invalid UTF-8 filenames as locale-specific.
	# FIXME : we should probably move to suggesting G_FILENAME_ENC
	dodir /etc/env.d
	echo "G_BROKEN_FILENAMES=1" > ${D}/etc/env.d/50glib2

	dodoc AUTHORS ChangeLog* README* INSTALL NEWS*

}
