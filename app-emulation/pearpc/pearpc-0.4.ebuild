# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/pearpc/pearpc-0.4.ebuild,v 1.5 2006/08/24 21:58:50 blubb Exp $

inherit eutils flag-o-matic linux-info

DESCRIPTION="PowerPC Architecture Emulator"
HOMEPAGE="http://pearpc.sourceforge.net/"
SRC_URI="mirror://sourceforge/pearpc/${P}.tar.bz2
	http://pearpc.sf.net/createdisk.py"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-amd64 ~x86"
IUSE="debug jit X sdl"

DEPEND="virtual/libc
	sys-devel/flex
	sys-devel/bison
	x86? ( dev-lang/nasm )
	jit? ( dev-lang/nasm )
	X? ( || ( x11-libs/libX11 virtual/x11 ) )
	sdl? ( >=media-libs/libsdl-1.2.0 )"
RDEPEND="${DEPEND}
	sys-apps/net-tools
	net-firewall/iptables
	net-misc/bridge-utils"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-configure.patch"
}

pkg_setup() {
	linux_chkconfig_present TUN && die "You must have TUN/TAP enabled in your kernel."
}

src_compile() {
	local myconf

	use jit && myconf="${myconf} --enable-cpu=jitc_x86"
	if use sdl; then
		myconf="${myconf} --enable-ui=sdl"
	elif use X; then
		myconf="${myconf} --enable-ui=x11"
	else
		die "You must set at least one of this flags X, sdl"
	fi

	append-ldflags $(bindnow-flags)

	econf \
		$(use_enable debug) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
	sed -i -e "s:video.x:/usr/share/${P}/video.x:g" ppccfg.example
}

src_install() {
	dobin src/ppc
	dodoc ChangeLog AUTHORS README TODO ppccfg.example

	insinto /usr/share/${P}
	doins scripts/ifppc_{down,up}{,.setuid} video.x "${FILESDIR}"/settings
	fperms u+s,a+x /usr/share/${P}/ifppc_{up,down}.setuid

	insinto /usr/share/${P}/scripts
	doins "${DISTDIR}"/createdisk.py
}

pkg_postinst() {
	einfo "You will need to update your configuration files to point"
	einfo "to the new location of video.x, which is now"
	einfo "/usr/share/${P}/video.x"
	einfo ""
	einfo "To create disk images for PearPC, you can use the Python"
	einfo "script located at: /usr/share/${P}/scripts/createdisk.py"
	einfo "Usage: createdisk.py <image name> <image size>"
	einfo ""
	einfo "Also, be sure to check /usr/share/doc/${P}/ppccfg.example.gz"
	einfo "for new configuration options."
}
