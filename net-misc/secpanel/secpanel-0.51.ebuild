# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/secpanel/secpanel-0.51.ebuild,v 1.2 2008/01/26 15:58:17 armin76 Exp $

DESCRIPTION="Graphical frontend for managing and running SSH and SCP connections"
HOMEPAGE="http://www.pingx.net/secpanel/"

SRC_URI="http://www.pingx.net/secpanel/${P/51/5.1}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="alpha ~amd64 ~sparc x86"
IUSE="gif"

DEPEND="!gif? ( media-gfx/imagemagick )"

RDEPEND="virtual/ssh dev-lang/tk"

S=${WORKDIR}/${P/51/5.1}

src_unpack() {
	unpack ${A}

	# optionally remove gifs...
	if ! use gif; then
		ebegin "Setting secpanel to use PPM images"
		sed -i 's/\.gif/\.ppm/g' ${S}/src/bin/secpanel
		eend $?
	fi
}

src_compile() {
	if ! use gif; then
		cd ${S}/src/lib/secpanel/images
		einfo "Converting all GIF images to PPM format..."
		for i in *.gif
		do
			ebegin "	${i} => ${i//.gif/.ppm}"
			convert ${i} "ppm:${i//.gif/.ppm}" || {
				eend $?
				die "convert failed"
			}
			eend $?
		done
		einfo "done."
	fi
}

src_install() {
	dobin ${S}/src/bin/secpanel
	dodir /usr/lib/secpanel /usr/lib/secpanel/images

	insinto /usr/lib/secpanel
	doins ${S}/src/lib/secpanel/*.{tcl,config,profile,dist,wait}

	insinto /usr/lib/secpanel/images

	if ! use gif; then
		doins ${S}/src/lib/secpanel/images/*.ppm
	else
		doins ${S}/src/lib/secpanel/images/*.gif
	fi

	fperms 755 /usr/lib/secpanel/{listserver.tcl,secpanel.dist,secpanel.wait}

	dodoc CHANGES COPYING README
}
