# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ohphone/ohphone-1.14.4.ebuild,v 1.1 2006/10/19 20:35:00 genstef Exp $

inherit eutils

MY_PV="v${PV//./_}"

DESCRIPTION="Command line H.323 client"
HOMEPAGE="http://www.openh323.org/"
SRC_URI="http://www.voxgratia.org/releases/ohphone-${MY_PV}-src-tar.gz"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="X svga"

RDEPEND="
	>=net-libs/openh323-1.15.6
	>=dev-libs/pwlib-1.8.7
	svga? ( media-libs/svgalib )"

S=${WORKDIR}/${PN}_${MY_PV}

src_unpack() {
	tar -xzf ${DISTDIR}/${A} -C ${WORKDIR} || die "Failed to unpack archive"

	cd ${S}

	use svga \
		|| sed -i -e "s:-lvga::" -e "s:-DHAS_VGALIB::" Makefile

	# pwlib sets P_SDL 0 if sdl support isn't present,
	# ohphone expects it to be undefined in that case...
	epatch ${FILESDIR}/${PN}-1.14.4-pwlibsdl.diff
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
	if use x86; then
		dobin obj_linux_x86_r/ohphone
	elif use ppc; then
		dobin obj_linux_ppc_r/ohphone
	else
		die "no binary available for your arch"
	fi
}
