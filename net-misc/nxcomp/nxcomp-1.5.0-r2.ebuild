# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxcomp/nxcomp-1.5.0-r2.ebuild,v 1.1 2006/04/30 17:42:53 stuart Exp $

inherit eutils

DESCRIPTION="X11 protocol compression library"
HOMEPAGE="http://www.nomachine.com/"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

SRC_URI="http://web04.nomachine.com/download/1.5.0/sources/$P-80.tar.gz"

# Add modular Xorg dependencies, but allow fallback to <7.0
RDEPEND="|| ( ( x11-libs/libX11
			x11-libs/libFS
			x11-libs/libXvMC
			media-libs/mesa
		)
		virtual/x11
	)
	>=media-libs/jpeg-6b-r4
	>=media-libs/libpng-1.2.8
	>=sys-libs/zlib-1.2.3
	virtual/libc"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xproto
			x11-proto/xf86vidmodeproto
			x11-proto/glproto
			x11-proto/videoproto
			x11-proto/xextproto
			x11-proto/fontsproto

			x11-misc/gccmakedep
			x11-misc/imake

			app-text/rman
		)
		virtual/x11
	)"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/nxcomp-1.5.0-r1-pic.patch
	epatch ${FILESDIR}/nxcomp-1.5.0-r1-gcc4.patch
}

src_compile() {
	econf --prefix="/usr/NX/" || die "Unable to configure nxcomp"
	emake || die "emake failed"
}

src_install() {
	into /usr/NX
	dolib libXcomp.so*
	if [[ $(get_libdir) != lib ]]; then
		# necessary for nxclient to work, it seems
		ln -s "$(get_libdir)" ${D}/usr/NX/lib
	fi

	insinto /usr/NX/include
	doins NX*.h MD5.h

	dodoc README README-IPAQ LICENSE VERSION

	# environment variables
	cat <<EOF > ${T}/50nxpaths
PATH=/usr/NX/bin
ROOTPATH=/usr/NX/bin
CONFIG_PROTECT="/usr/NX/etc /usr/NX/home"
PRELINK_PATH_MASK=/usr/NX
SEARCH_DIRS_MASK=/usr/NX
EOF
	doenvd ${T}/50nxpaths
}
