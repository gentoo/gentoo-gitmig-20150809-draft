# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vnc/vnc-4.0-r1.ebuild,v 1.19 2006/02/19 21:38:17 kumba Exp $

inherit eutils toolchain-funcs multilib

X_VERSION="6.8.1"

MY_P="${P}-unixsrc"
DESCRIPTION="Remote desktop viewer display system"
HOMEPAGE="http://www.realvnc.com/"
SRC_URI="http://www.realvnc.com/dist/${MY_P}.tar.gz
	server? (
		http://xorg.freedesktop.org/X11R${X_VERSION}/src/X11R${X_VERSION}-src1.tar.gz
		http://xorg.freedesktop.org/X11R${X_VERSION}/src/X11R${X_VERSION}-src2.tar.gz
		http://xorg.freedesktop.org/X11R${X_VERSION}/src/X11R${X_VERSION}-src3.tar.gz
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~mips ppc ppc64 sparc x86"
IUSE="server"

RDEPEND="sys-libs/zlib
	media-libs/freetype
	|| ( ( x11-libs/libSM
			x11-libs/libXtst
		)
		virtual/x11
	)
	server? ( || ( ( x11-libs/libXi
				x11-libs/libXmu
				x11-libs/libXrender
			)
			virtual/x11
		)
	)
	!net-misc/tightvnc"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xextproto
		)
		virtual/x11
	)"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.gz ; cd ${S}

	epatch ${FILESDIR}/${P}/vnc-gcc34.patch
	epatch ${FILESDIR}/${P}/vnc-cookie.patch
	epatch ${FILESDIR}/${P}/vnc-fPIC.patch
	epatch ${FILESDIR}/${P}/vnc-idle.patch
	epatch ${FILESDIR}/${P}/vnc-restart.patch
	epatch ${FILESDIR}/${P}/vnc-via.patch

	if use server; then
		unpack X11R${X_VERSION}-src1.tar.gz
		unpack X11R${X_VERSION}-src2.tar.gz
		unpack X11R${X_VERSION}-src3.tar.gz

		# patches from Redhat
		epatch ${FILESDIR}/${P}/vnc-sparc.patch
		epatch ${FILESDIR}/${P}/vnc-xorg-x11-fixes.patch
		epatch ${FILESDIR}/${P}/vnc-def.patch
		epatch ${FILESDIR}/${P}/vnc-xclients.patch
		epatch ${FILESDIR}/${P}/vnc-xorg.patch
		epatch ${FILESDIR}/${P}/imake-tmpdir.patch

		epatch ${FILESDIR}/xc.patch-cfbglblt8.patch
		epatch ${FILESDIR}/xc.patch-eieio.patch
		epatch xc.patch

		HOSTCONF="${S}/xc/config/cf/vnc.def"
		echo "#define CcCmd $(tc-getCC)" >> ${HOSTCONF}
		echo "#define FontDir /usr/share/fonts" >> ${HOSTCONF}
		echo "#define LibDir /usr/$(get_libdir)/X11" >> ${HOSTCONF}
		echo "#define UsrLibDir /usr/$(get_libdir)" >> ${HOSTCONF}
	fi
}

src_compile() {
	econf --with-installed-zlib || die
	emake || die

	if use server; then
		cd ${S}/xc
		make CDEBUGFLAGS="${CFLAGS}" CXXDEBUGFLAGS="${CXXFLAGS}" World FAST=1 || die
	fi
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	use server && dodir /usr/$(get_libdir)/modules/extensions

	./vncinstall ${D}/usr/bin ${D}/usr/share/man ${D}/usr/$(get_libdir)/modules/extensions || die
	dodoc LICENCE.TXT README

	use server || (
		rm ${D}/usr/bin/vncserver
		rm ${D}/usr/bin/x0vncserver
		rm ${D}/usr/share/man/man1/vncpasswd.1.gz
		rm ${D}/usr/bin/vncpasswd
		rm ${D}/usr/share/man/man1/vncconfig.1.gz
		rm ${D}/usr/bin/vncconfig
		rm ${D}/usr/share/man/man1/vncserver.1.gz
		rm ${D}/usr/share/man/man1/x0vncserver.1.gz
	)

	ewarn "Note that the free VNC release is not designed for use on untrusted networks"
}
