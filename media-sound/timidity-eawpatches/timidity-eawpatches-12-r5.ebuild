# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity-eawpatches/timidity-eawpatches-12-r5.ebuild,v 1.11 2007/02/06 13:33:22 blubb Exp $

IUSE=""

S=${WORKDIR}/eawpats

DESCRIPTION="Eric Welsh's GUS patches for TiMidity"
HOMEPAGE="http://www.stardate.bc.ca/eawpatches/html/default.htm"
SRC_URI="http://5hdumat.samizdat.net/music/eawpats${PV}_full.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86 ~x86-fbsd"

# These can be used for libmodplug too, so don't depend on timidity++
DEPEND="app-admin/eselect-timidity"
RDEPEND=""

RESTRICT="binchecks strip"

src_unpack() {
	unpack ${A}
	sed -i -e "s:dir /home/user/eawpats/:dir /usr/share/timidity/eawpatches:" "${S}/linuxconfig/timidity.cfg"
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
	dodoc $(find . -name \*.txt)
}

pkg_postinst() {
	eselect timidity update --global --if-unset
}
