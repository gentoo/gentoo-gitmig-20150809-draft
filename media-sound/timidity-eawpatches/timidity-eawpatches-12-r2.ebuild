# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity-eawpatches/timidity-eawpatches-12-r2.ebuild,v 1.7 2004/04/01 08:39:11 eradicator Exp $

DESCRIPTION="Eric Welsh's GUS patches for TiMidity"
HOMEPAGE="http://www.stardate.bc.ca/eawpatches/html/default.htm"
SRC_URI="http://5hdumat.samizdat.net/music/eawpats${PV}_full.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"

DEPEND="media-sound/timidity++"

S=${WORKDIR}/eawpats

src_unpack() {
	unpack ${A}
	cd ${S}/linuxconfig
	sed -i -e "s:dir /home/user/eawpats/:dir /usr/share/timidity/eawpatches:" timidity.cfg
}

src_install() {
	local instdir=/usr/share/timidity

	# Install base timidity configuration
	insinto ${instdir}
	doins linuxconfig/timidity.cfg
	rm -rf linuxconfig/ winconfig/

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
