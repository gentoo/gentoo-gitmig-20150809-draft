# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-libs/gnome-libs-1.4.1.7.ebuild,v 1.23 2004/11/08 14:55:22 vapier Exp $

inherit libtool

DESCRIPTION="GNOME Core Libraries"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha ppc sparc x86"
IUSE="doc nls kde"

RDEPEND=">=media-libs/imlib-1.9.10
	>=media-sound/esound-0.2.23
	=gnome-base/orbit-0*
	=x11-libs/gtk+-1.2*
	<sys-libs/db-2
	doc? ( app-text/docbook-sgml
		dev-util/gtk-doc )"
DEPEND="nls? ( >=sys-devel/gettext-0.10.40
	>=dev-util/intltool-0.11 )
	${RDEPEND}"

src_compile() {
	CFLAGS="$CFLAGS -I/usr/include/db1"

	local myconf

	use nls || myconf="${myconf} --disable-nls"
	use kde && myconf="${myconf} --with-kde-datadir=/usr/share"
	use doc || myconf="${myconf} --disable-gtk-doc"

	# libtoolize
	elibtoolize

	econf \
		--enable-prefer-db1 \
		${myconf} || die

	emake || die

	#do the docs (maybe add a use variable or put in seperate
	#ebuild since it is mostly developer docs?)
	if use doc
	then
		cd ${S}/devel-docs
		emake || die
		cd ${S}
	fi
}

src_install() {
	einstall \
		docdir=${D}/usr/share/doc \
		HTML_DIR=${D}/usr/share/gnome/html \
		|| die

	#do the docs
	if use doc
	then
		cd ${S}/devel-docs
			einstall || die
		cd ${S}
	fi

	rm ${D}/usr/share/gtkrc*
	rm -rf ${D}/usr/doc

	dodoc AUTHORS ChangeLog README NEWS HACKING
}
