# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/aumix/aumix-2.7-r4.ebuild,v 1.7 2002/09/19 03:16:20 owen Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Aumix volume/mixer control program."
SRC_URI="http://jpj.net/~trevor/aumix/${P}.tar.gz"
HOMEPAGE="http://jpj.net/~trevor/aumix/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=sys-libs/ncurses-5.2
	gpm?  ( >=sys-libs/gpm-1.19.3 )
	alsa? ( >=media-libs/alsa-lib-0.5.10 )
	gtk?  ( =x11-libs/gtk+-1.2* )
	nls?  ( sys-devel/gettext )"


src_compile() {

	local myconf
	use gpm  || myconf="--without-gpm"
	use nls  || myconf="--disable-nls"
	use gtk  || myconf="$myconf --without-gtk"
	use alsa || myconf="$myconf --without-alsa"
	
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/man \
		--host=${CHOST} \
		$myconf || die "./configure failed"
		
	emake || die "make failed"
}

src_install() {

	make DESTDIR=${D} install
	
	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README TODO
	
	if use gnome; then
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/aumix.desktop
		mkdir -p ${D}/usr/share/pixmaps
		ln -s ../aumix/aumix.xpm ${D}/usr/share/pixmaps
	fi
	
	exeinto /etc/init.d ; newexe ${FILESDIR}/aumix.rc6 aumix
}

