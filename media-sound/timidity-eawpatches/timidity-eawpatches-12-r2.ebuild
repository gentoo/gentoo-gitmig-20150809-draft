# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity-eawpatches/timidity-eawpatches-12-r2.ebuild,v 1.2 2003/06/12 21:11:49 msterret Exp $

S=${WORKDIR}/eawpats
DESCRIPTION="Eric Welsh's GUS patches for TiMidity"
SRC_URI="http://5hdumat.samizdat.net/music/eawpats${PV}_full.tar.gz"
HOMEPAGE="http://www.stardate.bc.ca/eawpatches/html/default.htm"

DEPEND="media-sound/timidity++"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

src_unpack() {
unpack ${A}
cd ${S}/linuxconfig
cp timidity.cfg timidity.cfg.orig
sed -e "s:dir /home/user/eawpats/:dir /usr/share/timidity/eawpatches:" timidity.cfg.orig > timidity.cfg
rm -f timidity.cfg.orig
}

src_install () {
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
