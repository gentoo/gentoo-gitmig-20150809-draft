# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ohphone/ohphone-1.4.1-r1.ebuild,v 1.6 2004/07/15 00:25:27 agriffis Exp $

DESCRIPTION="Command line H.323 client"
HOMEPAGE="http://www.openh323.org/"
SRC_URI="http://www.openh323.org/bin/${PN}_${PV}.tar.gz"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="X svga"

DEPEND=">=net-libs/openh323-1.12.2
	>=dev-libs/pwlib-1.5.2
	X? ( virtual/x11 )
	svga? ( media-libs/svgalib )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}

	use svga \
		|| sed -e "s:-lvga::" -e "s:-DHAS_VGALIB::" -i ${S}/Makefile \
		|| die "failed to turn off SVGAlib support"
}

src_compile() {
	local myopts

	use X \
		&& myopts="${myopts} XINCDIR=/usr/X11R6/include XLIBDIR=/usr/X11R6/lib" \
		|| myopts="${myopts} XINCDIR=/dev/null XLIBDIR=/dev/null"

	emake \
		OPENH323DIR=/usr/share/openh323 \
		PREFIX=/usr \
		PWLIBDIR=/usr/share/pwlib \
		PW_LIBDIR=/usr/lib \
		OH323_LIBDIR=/usr/lib \
		${myopts} \
		opt man || die
}

src_install() {
	cd ${WORKDIR}/${PN}
	doman ohphone.1

	# fill in for other archs
	if [ ${ARCH} = "x86" ]; then
		dobin obj_linux_x86_r/ohphone
	fi
}
