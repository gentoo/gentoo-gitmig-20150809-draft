# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/dgs/dgs-0.5.10-r1.ebuild,v 1.22 2004/04/03 14:52:23 usata Exp $

inherit gnuconfig

DESCRIPTION="A Ghostscript based DPS server"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/old/dgs/${P}.tar.gz"
HOMEPAGE="http://www.gyve.org/dgs/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha amd64 hppa ~mips"
IUSE="tcpd"

RDEPEND="=dev-libs/glib-1.2*
	virtual/x11"
DEPEND="${RDEPEND}
	sys-apps/texinfo
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

pkg_setup() {
	if has_version 'sys-apps/tcp-wrappers' && [ -z "`use tcpd`" ]; then
		ewarn "tcp-wrappers will be detected by the package and support will be enabled"
		ewarn "The package presently provides no way to disable tcp-wrappers support if you don't want it"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gs-time_.h-gentoo.diff
	use amd64 && gnuconfig_update
}

src_compile() {
	econf --with-x || die
	make || die
}

src_install() {
	einstall || die

	rm -rf ${D}/usr/share/man/manm
	newman ${S}/DPS/demos/xepsf/xepsf.man xepsf.1
	newman ${S}/DPS/demos/dpsexec/dpsexec.man dpsexec.1
	newman ${S}/DPS/clients/makepsres/makepsres.man makepsres.1

	dodoc ANNOUNCE ChangeLog FAQ NEWS NOTES README STATUS TODO Version
}
