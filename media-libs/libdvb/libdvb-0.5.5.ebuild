# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvb/libdvb-0.5.5.ebuild,v 1.2 2005/01/29 22:09:31 dragonheart Exp $

inherit eutils

DESCRIPTION="libdvb package with added CAM library and libdvbmpegtools as well as dvb-mpegtools"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ia64 ~amd64 ~ppc"
IUSE="doc"

DEPEND=">=sys-apps/sed-4
	>=media-tv/linuxtv-dvb-1.1.1"

src_unpack() {
	unpack ${A} && cd "${S}"

	# Disable compilation of sample programs
	# and use DESTDIR when installing
	epatch "${FILESDIR}/${P}-gentoo.patch" || die "patch failed"
	epatch ${FILESDIR}/errno.patch || die "patch failed"
}

src_compile() {
	emake || die "compile problem"
}

src_install() {
	#einstall DESTDIR="${D}" || die "Install problem"
	make DESTDIR="${D}" PREFIX=/usr install || die

	use doc && insinto "/usr/share/doc/${PF}/sample_progs" && \
	doins sample_progs/* && \
	insinto "/usr/share/doc/${PF}/samplerc" && \
	doins samplerc/*

	echo
	einfo "The script called 'dia' has been installed as dia-dvb"
	einfo "so that it doesn't overwrite the binary of app-office/dia."
	einfo

	dodoc README
}
