# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity-eawpatches/timidity-eawpatches-12.ebuild,v 1.3 2002/07/21 13:50:35 seemant Exp $

S=${WORKDIR}
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
	patch -p0 < "${FILESDIR}/${PF}-gentoo.diff"
}

src_install () {
	instdir=/usr/share/timidity/eawpatches
	insinto ${instdir}
	doins eawpatches/*

	# Make sure ownership and perms are sane
	cd ${D}/${instdir}
	chown -R root.root eawpatches
	chmod -R a+rX,go-w eawpatches

	# Install timidity.cfg where timidity can find it
	mv eawpatches/timidity.cfg .
}
