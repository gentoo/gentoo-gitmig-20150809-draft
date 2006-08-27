# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/pearpc/pearpc-0.3.1.ebuild,v 1.7 2006/08/27 10:09:09 blubb Exp $

inherit flag-o-matic

IUSE="debug jit sdl"
#IUSE="debug qt gtk jit sdl"

DESCRIPTION="PowerPC Architecture Emulator"
HOMEPAGE="http://pearpc.sourceforge.net/"
SRC_URI="mirror://sourceforge/pearpc/${P}.tar.bz2
	http://pearpc.sf.net/createdisk.py"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="x86? ( dev-lang/nasm )
	|| ( x11-libs/libXt virtual/x11 )"

RDEPEND="media-libs/libmng
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	media-libs/freetype
	sdl? ( media-libs/libsdl )"
#	gtk? ( >=x11-libs/gtk-2.0 )
#	qt? ( >=x11-libs/qt-3.1.1 )"

DEFAULT_TO_X11=0

pkg_setup() {

	append-ldflags -Wl,-z,now

#	if (use qt && use sdl) || (use qt && use gtk) || (use gtk && sdl) || (use gtk && use qt && use sdl); then
#		ewarn
#		ewarn "More than one frontend USE flags enabled, defaulting to X11 support."
#		ewarn
#		DEFAULT_TO_X11=1
#	fi		
}

src_compile() {
	local myconf
	myconf="--enable-release"

	use jit && myconf="${myconf} --enable-cpu=jitc_x86"

	if use debug; then
		myconf="${myconf} --enable-debug"
	else
		myconf="${myconf} --disable-debug"
	fi

	if [ $DEFAULT_TO_X11 = 1 ]; then
		myconf="${myconf} --enable-ui=x11"
	else
		if use sdl; then
			myconf="${myconf} --enable-ui=sdl"
#		elif use qt; then
#			myconf="${myconf} --enable-ui=qt"
#		elif use gtk; then
#			myconf="${myconf} --enable-ui=gtk"
		else
			myconf="${myconf} --enable-ui=x11"
		fi
	fi

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dobin src/ppc
	dodoc ChangeLog AUTHORS COPYING README TODO

	dodir /usr/share/${P}
	insinto /usr/share/${P}
	doins scripts/ifppc_down scripts/ifppc_up scripts/ifppc_up.setuid scripts/ifppc_down.setuid
	doins video.x
	fperms u+s /usr/share/${P}/ifppc_up.setuid /usr/share/${P}/ifppc_down.setuid

	insinto /usr/share/doc/${P}
	sed -i -e "s:video.x:/usr/share/${P}/video.x:g" ppccfg.example
	doins ppccfg.example

	dodir /usr/share/${P}/scripts
	insinto /usr/share/${P}/scripts
	doins ${DISTDIR}/createdisk.py
}

pkg_postinst() {
	echo
	einfo "You will need to update your configuration files to point"
	einfo "to the new location of video.x, which is now"
	einfo "/usr/share/${P}/video.x"
	echo
	einfo "To create disk images for PearPC, you can use the Python"
	einfo "script located at: /usr/share/${P}/scripts/createdisk.py"
	einfo "Usage: createdisk.py <image name> <image size>"
	echo
	einfo "Also, be sure to check /usr/share/doc/${P}/ppccfg.example"
	einfo "for new configuration options."
	echo
}
