# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ati-gatos/ati-gatos-4.3.0.ebuild,v 1.2 2004/01/14 00:58:02 battousai Exp $

inherit eutils

IUSE=""

DESCRIPTION="ATI Multimedia-capable drivers for XFree86"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://gatos.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="${DEPEND}
	x11-base/xfree"

pkg_setup() {
	if [ ! "`grep gatos /var/db/pkg/x11-base/xfree*/USE`" ]
	then
		ewarn "This package requires that xfree was merged with the gatos USE flag enabled."
		die "Please merge xfree with the gatos and sdk USE flags enabled."
	fi
}

src_compile() {
	cd ${S}

	# Build makefiles against XFree SDK
	imake -I/usr/X11R6/lib/Server/config/cf -DUseInstalled -DXF86DriverSDK

	# Makefile fixes
	fix_makefile

	emake DESTDIR=${D} || die "Problem compiling GATOS drivers."
}

src_install() {
	emake DESTDIR=${D} install
}

pkg_postinst() {
	einfo "To have XFree86 make use of the new GATOS modules, you should add the following"
	einfo "line to /etc/X11/XF86Config, in the files section and above any other"
	einfo "ModulePath directives:"
	einfo
	einfo "      ModulePath /usr/X11R6/lib/modules-extra/gatos"
	einfo
	einfo "Please note that you may need to uncomment or add another ModulePath line with"
	einfo "the default module path in it. If XFree86 does not start after adding the line"
	einfo "above, add this one under it:"
	einfo
	einfo "      ModulePath /usr/X11R6/lib/modules"
}

fix_makefile() {
	# Add the XFree86 SDK include directories that gatos will use
	sed -i "s:INCLUDES = \(.\+\):INCLUDES = \\1 -I/usr/X11R6/lib/Server/include -I/usr/X11R6/lib/Server/include/extensions:" Makefile

	# Clean up the ugly sandbox violations
	sed -i "s:\(\ \+\)MODULEDIR = .*:\\1MODULEDIR = \\\$(USRLIBDIR)/modules-extra/gatos:" Makefile
	sed -i "s:\(\ \+\)BUILDLIBDIR = .*:\\1BUILDLIBDIR = \\\$(DESTDIR)\\\$(TOP)/exports/lib:" Makefile
	sed -i "s:\\(.\+\)\\\$(RM) \\\$(BUILDMODULEDIR)/drivers/ati2_drv\.o:\\1\\\$(RM) \\\$(DESTDIR)\\\$(BUILDMODULEDIR)/drivers/ati2_drv.o:" Makefile
}
