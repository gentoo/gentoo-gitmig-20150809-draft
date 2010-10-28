# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/secpanel/secpanel-0.53.ebuild,v 1.3 2010/10/28 10:37:49 ssuominen Exp $

DESCRIPTION="Graphical frontend for managing and running SSH and SCP connections"
HOMEPAGE="http://themediahost.de/secpanel/"

SRC_URI="http://themediahost.de/secpanel/data/${P/53/5.3}.tgz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="alpha ~amd64 ~sparc x86"
IUSE="gif"

DEPEND="!gif? ( media-gfx/imagemagick )"

RDEPEND="virtual/ssh dev-lang/tk"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	# optionally remove gifs...
	if ! use gif; then
		ebegin "Setting secpanel to use PPM images"
		sed -i 's/\.gif/\.ppm/g' "${S}"/usr/local/bin/secpanel
		eend $?
	fi
}

src_compile() {
	if ! use gif; then
		cd "${S}"/usr/local/lib/secpanel/images
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
	dobin "${S}"/usr/local/bin/secpanel
	dodir /usr/lib/secpanel /usr/lib/secpanel/images

	insinto /usr/lib/secpanel
	doins "${S}"/usr/local/lib/secpanel/*.{tcl,config,profile,dist,wait}

	insinto /usr/lib/secpanel/images

	if ! use gif; then
		doins "${S}"/usr/local/lib/secpanel/images/*.ppm
	else
		doins "${S}"/usr/local/lib/secpanel/images/*.gif
	fi

	fperms 755 /usr/lib/secpanel/{listserver.tcl,secpanel.dist,secpanel.wait}

	cd "${S}"/usr/share/doc/${P/53/5.3/}
	dodoc CHANGES README
}
