# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity-eawpatches/timidity-eawpatches-12-r1.ebuild,v 1.3 2004/03/01 05:37:16 eradicator Exp $

S=${WORKDIR}/eawpatches
DESCRIPTION="Eric Welsh's GUS patches for TiMidity"
SRC_URI="http://www.stardate.bc.ca/eawpatches/eawpats${PV}_full.rar"
HOMEPAGE="http://www.stardate.bc.ca/eawpatches/html/default.htm"

DEPEND="media-sound/timidity++
	app-arch/unrar"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

src_unpack() {
	mkdir eawpatches
	cd eawpatches
	unrar x "${DISTDIR}/${A}" || die "error unpacking ${DISTDIR}/${A}"

	# Patch the default configuration so the patches can be found
	patch -p0 < "${FILESDIR}/${PN}-12-gentoo.diff"
}

src_install () {
	local instdir=/usr/share/timidity

	# Install base timidity configuration
	insinto ${instdir}
	doins timidity.cfg
	rm timidity.cfg

	# Install base eawpatches
	insinto ${instdir}/eawpatches
	doins *.cfg *.pat
	rm *.cfg *.pat

	# Install patches from subdirectories
	for d in `find . -type f -name \*.pat | sed 's,/[^/]*$,,' | sort -u`; do
		insinto ${instdir}/eawpatches/${d}
		doins ${d}/*.pat
	done

	# Install documentation, including subdirs
	find . -name \*.txt | xargs dodoc
}
