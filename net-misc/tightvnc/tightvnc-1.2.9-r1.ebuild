# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tightvnc/tightvnc-1.2.9-r1.ebuild,v 1.17 2006/04/23 22:08:00 morfic Exp $

inherit eutils toolchain-funcs

IUSE="java tcpd"

S="${WORKDIR}/vnc_unixsrc"
DESCRIPTION="A great client/server software package allowing remote network access to graphical desktops."
SRC_URI="mirror://sourceforge/vnc-tight/${P}_unixsrc.tar.bz2"
HOMEPAGE="http://www.tightvnc.com/"

KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"
LICENSE="GPL-2"
SLOT="0"

DEPEND="|| ( ( x11-libs/libXaw
						x11-proto/xextproto
						>=x11-misc/imake-1
						x11-misc/gccmakedep
						app-text/rman
						x11-libs/libXp
						x11-proto/inputproto
						x11-proto/kbproto
						x11-proto/printproto
						x11-proto/scrnsaverproto
				)
				virtual/x11
		)
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
	[[ "$(gcc-version)" == "3.4" ]] || [[ "$(gcc-major-version)" == "4" ]] && epatch ${FILESDIR}/${P}-gcc34.patch
	epatch ${FILESDIR}/x86.patch
	epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	local CDEBUGFLAGS="${CFLAGS}"

	xmkmf -a || die "xmkmf failed"

	make CDEBUGFLAGS="${CDEBUGFLAGS}" World || die "make World failed"
	cd Xvnc && ./configure || die "Configure failed."

	if use tcpd; then
		make EXTRA_LIBRARIES="-lwrap -lnss_nis" CDEBUGFLAGS="${CDEBUGFLAGS}" EXTRA_DEFINES="-DUSE_LIBWRAP=1"
	else
		make CDEBUGFLAGS="${CDEBUGFLAGS}"
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
