# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity-eawpatches/timidity-eawpatches-12-r4.ebuild,v 1.6 2006/05/03 06:03:26 corsair Exp $

IUSE=""

S=${WORKDIR}/eawpats

DESCRIPTION="Eric Welsh's GUS patches for TiMidity"
HOMEPAGE="http://www.stardate.bc.ca/eawpatches/html/default.htm"
SRC_URI="http://5hdumat.samizdat.net/music/eawpats${PV}_full.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 hppa ppc ~ppc64 sparc x86"

DEPEND=">=media-sound/timidity++-2.13.0-r2"

src_unpack() {
	unpack ${A}
	cd ${S}/linuxconfig
	sed -i -e "s:dir /home/user/eawpats/:dir /usr/share/timidity/eawpatches:" timidity.cfg
}

src_install() {
	local instdir=/usr/share/timidity

	# Set our installation directory
	insinto ${instdir}/eawpatches

	# Install base timidity configuration for timidity-update
	doins linuxconfig/timidity.cfg
	rm -rf linuxconfig/ winconfig/

	# Install base eawpatches
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

pkg_postinst() {
	einfo "You must run 'timidity-update -g -s eawpatches' to set this"
	einfo "patchset as the default system patchset."
}
