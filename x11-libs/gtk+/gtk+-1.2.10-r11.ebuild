# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-1.2.10-r11.ebuild,v 1.1 2004/02/05 22:32:49 spider Exp $

inherit eutils libtool

DESCRIPTION="The GIMP Toolkit"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/${P}.tar.gz
	ftp://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz
	http://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz
	http://www.ibiblio.org/gentoo/distfiles/gtk+-1.2.10-r8-gentoo.diff.bz2"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"
IUSE="nls debug"

RDEPEND="virtual/x11
	=dev-libs/glib-1.2*"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext
		dev-util/intltool )"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}/..
	epatch ${DISTDIR}/gtk+-1.2.10-r8-gentoo.diff.bz2

	# locale fix by sbrabec@suse.cz
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.2-locale_fix.patch
}

src_compile() {

	elibtoolize

	local myconf=
	use nls || myconf="${myconf} --disable-nls"

	if [ `use debug` ]
	then
		myconf="${myconf} --enable-debug=yes"
	else
		myconf="${myconf} --enable-debug=minimum"
	fi

	econf \
		--sysconfdir=/etc \
		--with-xinput=xfree \
		--with-x \
		${myconf} || die

	emake || die
}

src_install() {

	make install DESTDIR=${D} || die

	preplib /usr

	dodoc AUTHORS COPYING ChangeLog* HACKING
	dodoc NEWS* README* TODO
	docinto docs
	cd docs
	dodoc *.txt *.gif text/*
	dohtml -r html

	#install nice, clean-looking gtk+ style
	insinto /usr/share/themes/Gentoo/gtk
	doins ${FILESDIR}/gtkrc
}

pkg_postinst() {

	ewarn "Older versions added /etc/X11/gtk/gtkrc which changed settings for"
	ewarn "all themes it seems.  Please remove it manually as it will not due"
	ewarn "to /env protection."
	echo ""
	einfo "The old gtkrc is available through the new Gentoo gtk theme."

}
