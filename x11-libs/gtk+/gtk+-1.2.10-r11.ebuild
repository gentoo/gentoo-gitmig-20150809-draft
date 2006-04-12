# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtk+/gtk+-1.2.10-r11.ebuild,v 1.24 2006/04/12 14:40:09 flameeyes Exp $

GNOME_TARBALL_SUFFIX="gz"
inherit gnome.org eutils libtool toolchain-funcs

DESCRIPTION="The GIMP Toolkit"
HOMEPAGE="http://www.gtk.org/"
SRC_URI="${SRC_URI} http://www.ibiblio.org/gentoo/distfiles/gtk+-1.2.10-r8-gentoo.diff.bz2"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="nls debug"

RDEPEND="||	(
				(
					x11-libs/libXi
					x11-libs/libXt
				)
				virtual/x11
			)
		 =dev-libs/glib-1.2*"
DEPEND="${RDEPEND}
		||	(
				(
					x11-proto/inputproto
					x11-proto/xextproto
				)
				virtual/x11
			)
		nls? ( sys-devel/gettext dev-util/intltool )"

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${FILESDIR}"/${P}-m4.patch

	cd "${S}"/..
	epatch "${DISTDIR}"/gtk+-1.2.10-r8-gentoo.diff.bz2

	# locale fix by sbrabec@suse.cz
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.2-locale_fix.patch

	elibtoolize
}

src_compile() {
	local myconf=
	use nls || myconf="${myconf} --disable-nls"

	if use debug ; then
		myconf="${myconf} --enable-debug=yes"
	else
		myconf="${myconf} --enable-debug=minimum"
	fi

	econf \
		--sysconfdir=/etc \
		--with-xinput=xfree \
		--with-x \
		${myconf} || die

	emake CC="$(tc-getCC)" || die
}

src_install() {
	make install DESTDIR="${D}" || die

	dodoc AUTHORS ChangeLog* HACKING
	dodoc NEWS* README* TODO
	docinto docs
	cd docs
	dodoc *.txt *.gif text/*
	dohtml -r html

	#install nice, clean-looking gtk+ style
	insinto /usr/share/themes/Gentoo/gtk
	doins "${FILESDIR}"/gtkrc
}

pkg_postinst() {
	ewarn "Older versions added /etc/X11/gtk/gtkrc which changed settings for"
	ewarn "all themes it seems.  Please remove it manually as it will not due"
	ewarn "to /env protection."
	echo ""
	einfo "The old gtkrc is available through the new Gentoo gtk theme."
}
