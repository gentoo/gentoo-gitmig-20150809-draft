# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-1.0.5-r2.ebuild,v 1.7 2002/08/30 14:32:48 seemant Exp $

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Virtual File System."
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

SLOT="1"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND="( =gnome-base/gconf-1.0* )	
	>=gnome-base/gnome-libs-1.4.1.2
	>=gnome-base/gnome-mime-data-1.0.1
	>=sys-apps/bzip2-1.0.2
	ssl? ( dev-libs/openssl )"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.8.0
	>=dev-util/intltool-0.11
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	elibtoolize
	if [ -z "`use nls`" ]
	then
		myconf="${myconf} --disable-nls"
		mkdir intl
		touch intl/libgettext.h
	fi
	
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING* ChangeLog NEWS README
}
