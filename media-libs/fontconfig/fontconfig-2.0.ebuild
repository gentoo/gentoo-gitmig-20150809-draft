# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fontconfig/fontconfig-2.0.ebuild,v 1.1 2002/09/30 22:03:13 azarah Exp $

S="${WORKDIR}/fcpackage.${PV/\./_}/fontconfig"
DESCRIPTION="A library for configuring and customizing font access."
SRC_URI="http://fontconfig.org/release/fcpackage.${PV/\./_}.tar.gz"
HOMEPAGE="http://fontconfig.org/"

LICENSE="fontconfig"
SLOT="1.0"
KEYWORDS="x86"

DEPEND=">=media-libs/freetype-2.0.9
	>=dev-libs/expat-1.95.3"


src_compile() {
	econf || die
	
	emake || die
}

src_install() {
	einstall || die

	insinto /etc/fonts
	doins ${S}/fonts.conf

	cd ${S}
	
	mv fc-cache/fc-cache.man fc-cache/fc-cache.1
	mv fc-list/fc-list.man fc-list/fc-list.1
	mv src/fontconfig.man src/fontconfig.3
	for x in fc-cache/fc-cache.1 fc-list/fc-list.1 src/fontconfig.3
	do
		doman ${x}
	done

	dodoc AUTHORS COPYING ChangeLog NEWS README
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		einfo "Creating font cache..."
		/usr/bin/fc-cache
	fi
}

