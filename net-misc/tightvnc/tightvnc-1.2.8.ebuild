# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tightvnc/tightvnc-1.2.8.ebuild,v 1.4 2003/05/04 14:58:45 aliz Exp $

inherit eutils

IUSE="java tcpd"

S="${WORKDIR}/vnc_unixsrc"
DESCRIPTION="A great client/server software package allowing remote network access to graphical desktops."
SRC_URI="mirror://sourceforge/vnc-tight/${P}_unixsrc.tar.bz2"
HOMEPAGE="http://www.tightvnc.com/"

KEYWORDS="x86 ppc sparc alpha"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=x11-base/xfree-4.2.1
	~media-libs/jpeg-6b
	sys-libs/zlib
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )
	!net-misc/vnc"

RDEPEND="${DEPEND}
	dev-lang/perl
	java? ( || ( >=virtual/jdk-1.3.1-r7 >=virtual/jre-1.3.1-r7 ) )"

src_unpack() {
	unpack ${A} && cd ${S}
	epatch ${FILESDIR}/tightvnc-${PVR}-gentoo.diff
	epatch ${FILESDIR}/${P}-gentoo.security.patch
}

src_compile() {
	xmkmf -a || die "xmkmf failed"

	make CDEBUGFLAGS="$CFLAGS" World || die "make World failed"
	cd Xvnc && ./configure || die "Configure failed."

	if use tcpd; then
		make EXTRA_LIBRARIES="-lwrap -lnss_nis" CDEBUGFLAGS="$CFLAGS" EXTRA_DEFINES="-DUSE_LIBWRAP=1"
	else
		make CDEBUGFLAGS="$CFLAGS"
	fi
}

src_install() {
	# the web based interface and the java viewer need the java class files
	insinto /usr/share/tightvnc/classes ; doins classes/*

	dodir /usr/share/man/man1 /usr/bin
	./vncinstall ${D}/usr/bin ${D}/usr/share/man || die "vncinstall failed"

	dodoc ChangeLog README WhatsNew 
	use java && dodoc ${FILESDIR}/README.JavaViewer
	newdoc vncviewer/README README.vncviewer
}
