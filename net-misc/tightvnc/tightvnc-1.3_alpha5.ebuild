# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit eutils

IUSE="java tcpd"

DLFILE="`echo ${P} | sed s:_alpha:dev:`"

S="${WORKDIR}/vnc_unixsrc"
DESCRIPTION="A great client/server software package allowing remote network access to graphical desktops."
SRC_URI="mirror://sourceforge/vnc-tight/${DLFILE}_unixsrc.tar.bz2"
HOMEPAGE="http://www.tightvnc.com/"

#can't test on anything but x86
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/x11
	~media-libs/jpeg-6b
	sys-libs/zlib
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )
	!net-misc/vnc"

RDEPEND="${DEPEND}
	dev-lang/perl
	java? ( || ( >=virtual/jdk-1.3.1 >=virtual/jre-1.3.1 ) )"

src_unpack() {
	unpack ${A} && cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	epatch ${FILESDIR}/${P}-gentoo.security.patch
	epatch ${FILESDIR}/${P}-imake-tmpdir.patch
	epatch ${FILESDIR}/x86.patch
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {
	local CDEBUGFLAGS="${CFLAGS}"

	use amd64 && CDEBUGFLAGS="${CDEBUGFLAGS} -m32 \
		-L/emul/linux/x86/lib \
		-L/emul/linux/x86/usr/lib/gcc-lib/i386-pc-linux-gnu/3.2.3 \
		-L/emul/linux/x86/usr/lib -L/emul/linux/x86/usr/X11R6/lib"

	xmkmf -a || die "xmkmf failed"

	make CDEBUGFLAGS="${CDEBUGFLAGS}" World || die "make World failed"
	cd Xvnc && ./configure || die "Configure failed."

	if use tcpd; then
		make EXTRA_LIBRARIES="-lwrap -lnss_nis" CDEBUGFLAGS="${CDEBUGFLAGS}" EXTRA_DEFINES="-DUSE_LIBWRAP=1" || die
	else
		make CDEBUGFLAGS="${CDEBUGFLAGS}" || die
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
