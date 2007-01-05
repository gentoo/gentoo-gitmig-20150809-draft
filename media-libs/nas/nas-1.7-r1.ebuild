# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/nas/nas-1.7-r1.ebuild,v 1.15 2007/01/05 17:16:34 flameeyes Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Network Audio System"
HOMEPAGE="http://radscan.com/nas.html"
SRC_URI="http://radscan.com/nas/${P}.src.tar.gz"

LICENSE="X11"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| (
		(
			x11-libs/libXt
			x11-libs/libXau
			x11-libs/libXaw
			x11-libs/libX11
			x11-libs/libXres
			x11-libs/libXTrap
			x11-libs/libXp
		)
		virtual/x11
	)"
DEPEND="${RDEPEND}
	|| (
		( x11-misc/gccmakedep x11-misc/imake app-text/rman x11-proto/xproto )
		virtual/x11
	)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-header.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch
}

src_compile() {
	xmkmf || die
	touch doc/man/lib/tmp.{_man,man}
	emake \
		MAKE="${MAKE:-gmake}" CDEBUGFLAGS="${CFLAGS}" CXXDEBUFLAGS="${CXXFLAGS}" \
		CC="$(tc-getCC)" CXX="$(tc-getCXX)" AS="$(tc-getAS)" LD="$(tc-getLD)" \
		RANLIB="$(tc-getRANLIB)" World || die
}

src_install () {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} install.man || die

	dodoc BUGS BUILDNOTES FAQ HISTORY README RELEASE TODO
	mv ${D}/usr/lib/X11/doc/html ${D}/usr/share/doc/${P}/
	rmdir ${D}/usr/lib/X11/doc

	# rename example nasd.conf.eg to nasd.conf and change it so that NAS
	# doesn't change mixer's settings (inspired by Debian package):
	mv ${D}/etc/nas/nasd.conf{.eg,}
	sed -i -e 's,\(MixerInit.*\)"\(.*\)",\1"no",' ${D}/etc/nas/nasd.conf

	newconfd "${FILESDIR}"/nas.conf.d nas
	newinitd "${FILESDIR}"/nas.init.d nas
}

pkg_postinst() {
	elog "To enable NAS on boot you will have to add it to the"
	elog "default profile, issue the following command as root to do so."
	elog ""
	elog "rc-update add nas default"
}
