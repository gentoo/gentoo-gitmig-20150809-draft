# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xosd/xosd-2.2.12.ebuild,v 1.1 2004/11/06 15:12:17 lanius Exp $

inherit eutils

IUSE="xinerama xmms bmp"

DESCRIPTION="Library for overlaying text/glyphs in X-Windows X-On-Screen-Display plus binary for sending text from command line"
HOMEPAGE="http://www.ignavus.net/"
SRC_URI="http://www.ignavus.net/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~hppa ~ia64 ~amd64"

DEPEND="virtual/x11
	bmp? (media-sound/beep-media-player >=media-libs/gdk-pixbuf-0.22.0 )
	xmms? ( media-sound/xmms >=media-libs/gdk-pixbuf-0.22.0 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/2.2.8-xmms-trackpos.patch
}

src_compile() {
	local myconf=""

	use xinerama || myconf="${myconf} --disable-xinerama"

	use xmms || use bmp || myconf="${myconf} --disable-new-plugin"

	if use bmp ; then
		# The files from xmms_plugin need to be copied over and patched with sed and epatch
		mkdir ${S}/src/bmp_plugin
		cp ${S}/src/xmms_plugin/* ${S}/src/bmp_plugin/

		# Add the bmp_plugin directory to the configure script
		sed -i -e 's: src/xmms_plugin/Makefile : src/xmms_plugin/Makefile src/bmp_plugin/Makefile :g' configure

		# Add the directory to the Makefile.* files in the src/ directory so that the Makefile
		# will be generated properly
		cd ${S}/src
		echo	"Makefile.in
			Makefile.am" | xargs sed -i -e 's:xmms_plugin:xmms_plugin bmp_plugin:g'

		# Convert the right "xmms"es to "bmp"s
		cd ${S}/src/bmp_plugin
		echo    "Makefile
			Makefile.in" | xargs sed -i -e 's:libxmms_osd:libbmp_osd:g' -e 's:/xmms/:/bmp/:g'

		# Finally, apply a trivial patch
		epatch ${FILESDIR}/bmp-dlg_config.patch

		cd ${S}
	fi

	econf ${myconf} || die

	# Since the "--disable-new-plugin" flag was enabled if the 'bmp' or 'xmms' USE flag was specified,
	# the src/xmms_plugin directory has to be manually removed from the Makefile in the src/ directory
	# if the user didn't want the xmms plugin to be compiled
	use xmms || (cd ${S}/src && sed -i -e 's:xmms_plugin::g' Makefile)
	# Fix some things not done right by econf in the src/bmp_plugin directory
	use bmp && (cd ${S}/src/bmp_plugin && sed -i -e 's:xmms-config:beep-config:g' -e 's:libdir)/xmms:libdir)/bmp:g' -e 's:-lxmms:-lbeep:g' -e 's:xmms/:bmp/:g' Makefile)

	cd ${S}

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS COPYING README

	if [ -d ${D}no ]; then
		rmdir ${D}no
	fi
}
