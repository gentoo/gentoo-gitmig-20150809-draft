# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/bitchx/bitchx-1.0.19-r1.ebuild,v 1.5 2002/07/16 04:54:32 seemant Exp $

MY_P=ircii-pana-${PV/.0./.0c}
S=${WORKDIR}/BitchX
DESCRIPTION="An IRC Client"
SRC_URI="ftp://ftp.bitchx.com/pub/BitchX/source/${MY_P}.tar.gz"
HOMEPAGE="http://www.bitchx.com/"

DEPEND=">=sys-libs/ncurses-5.1 
	ssl? ( >=dev-libs/openssl-0.9.6 )
	xmms? ( media-sound/xmms )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	ncurses? ( sys-libs/ncurses )
	esd? ( >=media-sound/esound-0.2.5
		>=media-libs/audiofile-0.1.5 )
	gtk? ( =x11-libs/gtk+-1.2*
		>=media-libs/imlib-1.9.10-r1 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

#src_unpack() {
#	unpack ${A}
#	cd ${S}
#	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff || die
#	patch -p1 < ${FILESDIR}/${P}-dupver.patch || die
#}

src_compile() {

	local myconf

	use ssl \
		&& myconf="${myconf} --with-ssl" \
		|| myconf="${myconf} --without-ssl"

	use esd && use gtk \
		&& myconf="${myconf} --enable-sound" \
		|| myconf="${myconf} --disable-sound"
	
	use gtk \
	    || myconf="${myconf} --without-gtk"

	use ipv6 \
		&& myconf="${myconf} --enable-ipv6" \
		|| myconf="${myconf} --disable-ipv6"

	#not tested
#	use ncurses \
#		&& myconf="${myconf} --without-tgetent" \
#		|| myconf="${myconf} --with-tgetent"
	
	use socks5 \
		&& myconf="${myconf} --with-socks=5" \
		|| myconf="${myconf} --without-socks"

	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		--build=${CHOST} \
		--enable-cdrom \
		--with-plugins \
		${myconf} || die

	emake || die

}

src_install () {

	make \
		prefix=${D}/usr \
		install || die

	cd ${D}/usr/bin

	use gnome && ( \
		exeinto /usr/bin
		newexe ${S}/source/BitchX BitchX-1.0c19
		dosym gtkBitchX-1.0c19 /usr/bin/gtkBitchX
	)

	dosym BitchX-1.0c19 /usr/bin/BitchX

	chmod -x ${D}/usr/lib/bx/plugins/BitchX.hints

	cd ${S}
		dodoc Changelog README* IPv6-support
		cd doc
		insinto /usr/X11R6/include/bitmaps
		doins BitchX.xpm

		dodoc BitchX-* BitchX.bot *.doc BitchX.faq README.hooks 
		dodoc bugs *.txt functions ideas mode tcl-ideas watch
		dodoc *.tcl
		dohtml *.html

		docinto plugins
		dodoc plugins
		cd ../dll
		insinto /usr/lib/bx/wav
		doins wavplay/*.wav
		cp acro/README acro/README.acro
		dodoc acro/README.acro
		cp arcfour/README arcfour/README.arcfour
		dodoc arcfour/README.arcfour
		cp blowfish/README blowfish/README.blowfish
		dodoc blowfish/README.blowfish
		dodoc nap/README.nap
		cp qbx/README qbx/README.qbx
		dodoc qbx/README.qbx
}
