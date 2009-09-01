# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/squeak-basicimage/squeak-basicimage-3.10.ebuild,v 1.2 2009/09/01 10:11:35 patrick Exp $

MY_P="Squeak${PV}-7159"
DESCRIPTION="Squeak basic image file"
HOMEPAGE="http://www.squeak.org/"
SRC_URI="http://ftp.squeak.org/${PV}/${MY_P}-basic.zip
		http://ftp.squeak.org/${PV}/SqueakV39.sources.gz"

LICENSE="Apple"
SLOT="3.10"
KEYWORDS="~amd64 ~x86"
IUSE=""
PROVIDE="virtual/squeak-image"

DEPEND="app-arch/unzip"
RDEPEND="!dev-lang/squeak-fullimage"

S=${WORKDIR}

src_compile() {
	einfo "Compressing image/changes files."
	gzip ${MY_P}-basic.image
	gzip ${MY_P}-basic.changes
	einfo "done."
}

src_install() {
	einfo 'Installing Image/Sources/Changes files.'
	insinto /usr/lib/squeak
	# install full image and changes file.
	doins ${MY_P}-basic.image.gz
	doins ${MY_P}-basic.changes.gz
	# create symlinks to the changes and image files.
	dosym "/usr/lib/squeak/${MY_P}-basic.changes.gz" \
		/usr/lib/squeak/squeak.changes.gz
	dosym "/usr/lib/squeak/${MY_P}-basic.image.gz" \
		/usr/lib/squeak/squeak.image.gz
	# install sources
	doins SqueakV39.sources
}

pkg_postinst() {
	elog "Squeak ${PV} image, changes and sources files installed in /usr/lib/squeak"
}
