# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/enlightenment/enlightenment-0.16.6.ebuild,v 1.9 2004/01/08 20:43:43 agriffis Exp $

DESCRIPTION="Enlightenment Window Manager"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://sourceforge/enlightenment/${P/_/-}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64"
IUSE="nls esd gnome kde"

DEPEND=">=media-libs/fnlib-0.5
	esd? ( >=media-sound/esound-0.2.19 )
	=media-libs/freetype-1*
	>=gnome-base/libghttp-1.0.9-r1
	>=media-libs/imlib-1.9.8"
RDEPEND="nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-${PV/_pre?/}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-kde-menu.patch
	epatch ${FILESDIR}/${PV}-edox.patch
}

src_compile() {
#		`use_enable gnome hints-gnome` \
#		`use_enable kde hints-kde` \
	econf \
		`use_enable nls` \
		`use_enable esd sound` \
		--enable-upgrade \
		--enable-hints-ewmh \
		--enable-fsstd \
		--enable-zoom \
		|| die
	#enlightenment's makefile uses the $USER env var (bad), which may not be
	#set correctly if you did a "su" to get root before emerging. Normally,
	#your $USER will still exist when you su (unless you enter a chroot,) but
	#will cause perms to be wrong. This fixes this:
	export USER=root
	emake || die
}

src_install() {
	export USER=root
	emake install DESTDIR=${D} || die
	mv ${D}/usr/bin/{,e}dox
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/enlightenment

	dodoc AUTHORS ChangeLog FAQ INSTALL NEWS README

	# fix default xcursor support
	cd ${D}/usr/share/enlightenment/themes
	local deftheme=`readlink DEFAULT`
	cp -rf ${deftheme} ${deftheme}-xcursors
	rm DEFAULT
	ln -s ${deftheme}-xcursors DEFAULT
	rm -rf ${deftheme}-xcursors/cursors*
	cp ${FILESDIR}/cursors.cfg ${deftheme}-xcursors/
}
