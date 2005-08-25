# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-2.8.1.ebuild,v 1.1 2005/08/25 01:16:56 leonardop Exp $

inherit gnome.org libtool eutils flag-o-matic debug

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="http://www.gtk.org/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~s390 ~sparc ~x86"
IUSE="debug doc hardened static"

DEPEND=">=dev-util/pkgconfig-0.14
	>=sys-devel/gettext-0.11
	doc? (
		>=dev-util/gtk-doc-1.4
		~app-text/docbook-xml-dtd-4.1.2 )"

RDEPEND="virtual/libc"


src_unpack() {
	unpack "${A}"
	cd "${S}"

	use ppc-macos && epatch ${FILESDIR}/${PN}-2-macos.patch

	if use ppc64 && use hardened; then
		replace-flags -O[2-3] -O1
		epatch ${FILESDIR}/glib-2.6.3-testglib-ssp.patch
	fi
}

src_compile() {
	local myconf="--with-threads=posix $(use_enable static) \
		$(use_enable doc gtk-doc) $(use_enable debug)"

	epunt_cxx

	if use ppc-macos; then
		glibtoolize
		append-ldflags "-L/usr/lib -lpthread"
	fi

	econf $myconf || die "./configure failed"
	emake || die "Compilation failed"
}

src_install() {

	make DESTDIR="${D}" install || die

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
