# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-1.0.5-r3.ebuild,v 1.17 2004/11/08 15:06:47 vapier Exp $

inherit eutils libtool gcc

DESCRIPTION="GNOME Virtual File System"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/${PN}/1.0/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="1"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips ~ppc64 arm"
IUSE="doc ssl nls"

RDEPEND="=gnome-base/gconf-1.0*
	>=gnome-base/gnome-libs-1.4.1.2
	>=gnome-base/gnome-mime-data-1.0.1
	>=app-arch/bzip2-1.0.2
	ssl? ( dev-libs/openssl )"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.8.0
	>=dev-util/intltool-0.11
	>=gnome-base/gnome-common-1.2.4
	nls? ( sys-devel/gettext )
	doc? ( dev-util/gtk-doc )"
# gnome-common is for m4 macros needed for patches ...


src_unpack() {
	unpack ${A}

	cd ${S}
	# Add missing macros for charset conversion
	epatch ${FILESDIR}/1.0/${P}-codeset.patch
	# Use GNOME2 Gconf keys for proxy settings
	epatch ${FILESDIR}/1.0/${P}-proxy.patch
	# Avoid openjade errors. See bug #46266.
	epatch ${FILESDIR}/1.0/${P}-gtkdoc_fixes.patch

	# Fix a rare segfault with gnome-mime-data-2.0.1.  Weird one really ...
	# <azarah@gentoo.org> (2 Jan 2003).
	epatch ${FILESDIR}/1.0/${P}-fix-segfault.patch

	#apply both patches to compile with gcc-3.4 closing bug #53075
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		epatch ${FILESDIR}/1.0/${P}-gcc3.4.patch
	fi


	autoheader
	aclocal -I /usr/share/aclocal/gnome-macros
	autoconf
}

src_compile() {
	local myconf=""

	elibtoolize

	use nls || {
		myconf="${myconf} --disable-nls"
		mkdir intl
		touch intl/libgettext.h
	}

	myconf="${myconf} $(use_enable doc gtk-doc)"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	rmdir ${D}/usr/doc

	dodoc AUTHORS COPYING* ChangeLog NEWS README
}
