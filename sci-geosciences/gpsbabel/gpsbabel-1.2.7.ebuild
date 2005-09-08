# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gpsbabel/gpsbabel-1.2.7.ebuild,v 1.1 2005/09/08 02:49:42 ribosome Exp $

inherit eutils toolchain-funcs

DESCRIPTION="GPSBabel converts waypoints, tracks, and routes from one format to another"

HOMEPAGE="http://www.gpsbabel.org/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE="usb debug"

DEPEND="dev-libs/expat
	virtual/tetex
	usb? (dev-libs/libusb)
	debug? (dev-util/efence)"

src_compile() {
	cd "${S}"
	local serror
	serror="Unable to modify Makefile with sed"
	if use debug; then
	    sed "s/# -lefence/-lefence/" -i Makefile || die "${serror} (efence)"
	fi
	if use usb; then
		einfo "Usb support will be enabled"
	else
		sed "s/LIBUSB=/INHIBIT_USB=-DNO_USB\nLIBUSB=#/" -i Makefile || \
			die "${serror} (usb)"
	fi
	sed "s/OPTIMIZATION=-O/OPTIMIZATION=${CFLAGS} /" -i Makefile || \
		die	"${serror} (optimization)"

	emake CC="$(tc-getCC)" || die "emake failed, see messages above"

	cd "${S}"/doc/
	make || die "Documentation generation failed"
}

src_install() {
	cd "${S}"
	dobin gpsbabel || die "Unable to install gpsbabel binary"
	dodoc README* COPYING ChangeLog || die "Unable to install gpsbabel doc"

	local DDIR
	DDIR="/usr/share/doc/${PF}/samples"
	sed -e "s:\./gpsbabel:gpsbabel:" \
		-e "s:reference:${DDIR}/reference:" \
		-i testc || die "${serror} (samples)"
	insinto ${DDIR}/scripts
	doins contrib/gpx2xfig testc || \
		die "Unable to install gpsbabel test scripts"
	chmod 0755 "${D}"/${DDIR}/scripts/testc
	for i in reference reference/route reference/track reference/gc; do
	    insinto ${DDIR}/${i}
	    doins ${i}/* || die "Unable to install samples from ${i} directory"
	done

	cd "${S}"/doc/
	insinto /usr/share/doc/${PF}/manual
	doins doc.dvi babelfront2.eps || \
		die "Unable to install gpsbabel documentation"
}
