# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/ogre/ogre-0.11.0-r1.ebuild,v 1.1 2003/08/16 06:26:39 vapier Exp $

DESCRIPTION="Object-oriented Graphics Rendering Engine"
HOMEPAGE="http://ogre.sourceforge.net/"
SRC_URI="mirror://sourceforge/ogre/ogre-v${PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE="doc gtk2"

DEPEND="dev-libs/STLport
	media-libs/libsdl
	virtual/opengl
	=media-libs/freetype-2*
	media-libs/devil
	sys-libs/zlib
	gtk2? (
		=dev-cpp/libglademm-2*
		=dev-cpp/gtkmm-2*
	)"

S=${WORKDIR}/ogrenew

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:noinst_HEADERS:pkginclude_HEADERS:' `find PlugIns/ -name 'Makefile.am'` || die "installing plugin headers"
}

src_compile() {
	local mycfgtk
	[ `use gtk2` ] \
		&& mycfgtk=gtk \
		|| mycfgtk=cli
	econf --with-cfgtk=${mycfgtk} || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	[ `use doc` ] && dohtml -r Docs/Docs/* Docs/Tutorials/*
	insinto /usr/share/OGRE/Media
	doins Samples/Media/*
	dodoc AUTHORS BUGS LINUX.DEV README Docs/README.linux
	dohtml Docs/*.html
}
