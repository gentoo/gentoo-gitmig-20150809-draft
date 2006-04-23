# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tightvnc/tightvnc-1.3_alpha7.ebuild,v 1.8 2006/04/23 22:08:00 morfic Exp $

inherit eutils toolchain-funcs

IUSE="java tcpd server"

S="${WORKDIR}/vnc_unixsrc"
DESCRIPTION="A great client/server software package allowing remote network access to graphical desktops."
SRC_URI="mirror://sourceforge/vnc-tight/${P/_alpha/dev}_unixsrc.tar.bz2"
HOMEPAGE="http://www.tightvnc.com/"

KEYWORDS="~alpha ~amd64 ~ppc ~ppc-macos ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="|| ( ( x11-libs/libXaw
			x11-proto/xextproto
			>=x11-misc/imake-1
			x11-misc/gccmakedep
			app-text/rman
			server? ( x11-libs/libXp
				x11-proto/inputproto
				x11-proto/kbproto
				x11-proto/printproto
				x11-proto/scrnsaverproto
			)
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

	if ! use server;
	then
		echo
		einfo "The 'server' USE flag will build tightvnc's server."
		einfo "If '-server' is chosen only the client is built to save space."
		einfo "Stop the build now if you need to add 'server' to USE flags.\n"
		ebeep
		epause 5
	fi

	unpack ${A} && cd ${S}
	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/${P}-gentoo.security.patch"
	epatch "${FILESDIR}/${P}-imake-tmpdir.patch"
	epatch "${FILESDIR}/x86.patch"
	epatch "${FILESDIR}/${P}-darwin.patch"
	epatch "${FILESDIR}/vncserver-1.3.patch"
	use amd64 && epatch "${FILESDIR}/${P}-amd64.patch"
}

src_compile() {
	xmkmf -a || die "xmkmf failed"

	make CDEBUGFLAGS="${CFLAGS}" World || die

	if use server; then
		cd Xvnc && ./configure || die "Configure failed."
		if use tcpd; then
			local myextra="-lwrap"
			use userland_Darwin || myextra="${myextra} -lnss_nis"
			make EXTRA_LIBRARIES="${myextra}" \
				CDEBUGFLAGS="${CFLAGS}"  \
				EXTRA_DEFINES="-DUSE_LIBWRAP=1" || die
		else
			make CDEBUGFLAGS="${CFLAGS}" || die
		fi
	fi

}

src_install() {
	# the web based interface and the java viewer need the java class files
	if use java; then
		insinto /usr/share/tightvnc/classes
		doins classes/*
	fi

	dodir /usr/share/man/man1 /usr/bin
	./vncinstall ${D}/usr/bin ${D}/usr/share/man || die "vncinstall failed"

	if ! use server; then
		rm -f ${D}/usr/bin/vncserver
		rm -f ${D}/usr/share/man/man1/{Xvnc,vncserver}*
	fi

	dodoc ChangeLog README WhatsNew
	use java && dodoc ${FILESDIR}/README.JavaViewer
	newdoc vncviewer/README README.vncviewer
}
