# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fontconfig/fontconfig-2.0-r3.ebuild,v 1.4 2003/02/13 12:42:54 vapier Exp $

inherit debug

S="${WORKDIR}/fcpackage.${PV/\./_}/fontconfig"
DESCRIPTION="A library for configuring and customizing font access."
SRC_URI="http://fontconfig.org/release/fcpackage.${PV/\./_}.tar.gz"
HOMEPAGE="http://fontconfig.org/"

LICENSE="fontconfig"
SLOT="1.0"
KEYWORDS="x86 alpha ppc sparc "

DEPEND=">=media-libs/freetype-2.0.9
	>=dev-libs/expat-1.95.3
	>=sys-apps/ed-0.2"


src_unpack() {
	unpack ${A}
	
	cd ${S}
	local PPREFIX="${FILESDIR}/patch/${PN}"
	einfo "Applying patches..."
	# Some patches from Redhat
	patch -p1 < ${PPREFIX}-2.0-defaultconfig.patch &> /dev/null || die
	patch -p1 < ${PPREFIX}-0.0.1.020811.1151-slighthint.patch &> /dev/null || die
	# Blacklist certain fonts that freetype can't handle
	patch -p1 < ${PPREFIX}-0.0.1.020826.1330-blacklist.patch &> /dev/null || die
	# Patch from Keith Packard to fix problem where 
	# subdirectories could get lost from ~/.fonts.cache
	patch -p1 < ${PPREFIX}-2.0-subdir.patch &> /dev/null || die
	# Remove stupid date, as a lot of users do not seem to know
	# how to use 'zic' ...
	patch -p2 < ${PPREFIX}-2.0-remove-stupid-date.patch &> /dev/null || die
	# Fix problem with italic fonts if no map file present
	patch -p2 < ${PPREFIX}-2.0-font-matrix.patch &> /dev/null || die
}

src_compile() {
	econf \
		--x-includes=/usr/X11R6/include \
		--x-libraries=/usr/X11R6/lib || die
	
	emake || die
}

src_install() {
	einstall confdir=${D}/etc/fonts \
		datadir=${D}/usr/share || die

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

