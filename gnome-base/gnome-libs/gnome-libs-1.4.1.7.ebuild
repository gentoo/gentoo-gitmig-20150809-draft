# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-libs/gnome-libs-1.4.1.7.ebuild,v 1.18 2004/04/03 19:24:00 leonardop Exp $

IUSE="doc nls kde"

inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Core Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

RDEPEND=">=media-libs/imlib-1.9.10
	>=media-sound/esound-0.2.23
	>=gnome-base/ORBit-0.5.12
	=x11-libs/gtk+-1.2*
	<sys-libs/db-2
	doc? ( app-text/docbook-sgml
		dev-util/gtk-doc )"

DEPEND="nls? ( >=sys-devel/gettext-0.10.40
	>=dev-util/intltool-0.11 )
	${RDEPEND}"

SLOT="1"

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
	if [ -n "`use doc`" ]
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
	if [ -n "`use doc`" ]
	then
		cd ${S}/devel-docs
			einstall || die
		cd ${S}
	fi

	rm ${D}/usr/share/gtkrc*
	rm -rf ${D}/usr/doc

	dodoc AUTHORS COPYING* ChangeLog README NEWS HACKING
}
