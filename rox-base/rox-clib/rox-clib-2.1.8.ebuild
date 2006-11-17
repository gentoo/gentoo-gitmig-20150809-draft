# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-clib/rox-clib-2.1.8.ebuild,v 1.6 2006/11/17 12:56:17 nixnut Exp $

MY_PN="ROX-CLib"
DESCRIPTION="A library for ROX applications written in C."
HOMEPAGE="http://rox.sourceforge.net/"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0.1
	>=dev-libs/libxml2-2.4.0"

DEPEND="$RDEPEND
	>=dev-util/pkgconfig-0.20"

S=${WORKDIR}/ROX-CLib
APPNAME=${MY_PN}

src_compile() {
	chmod 0755 AppRun

	# Most rox self-compiles have a 'read' call to wait for the user to
	# press return if the compile fails.
	# Find and remove this:
	sed -i.bak -e 's/\<read WAIT\>/#read/' AppRun

	./AppRun --compile || die "Could not make ROX-CLib. Sorry."

	# Restore the original AppRun
	mv AppRun.bak AppRun
}
src_install() {
	#  clean up source instead of remove it!
	( cd src && make clean )
	# remove silly .cvs files
	find . -name '.cvs*' | xargs rm -f >/dev/null 2>&1
	dodoc /usr/lib/${APPNAME}
	dodir /usr/lib/${APPNAME}
	cp -r . ${D}/usr/lib/${APPNAME}
	cd Help
	dodoc Authors Changes ToDo COPYING README Versions
	#finally link the html and latex dirs
	cd ${D}/usr/share/doc/${P}
	ln -s /usr/lib/${APPNAME}/Help/rox-clib.html rox-clib.html
	ln -s /usr/lib/${APPNAME}/Help/libdir.html libdir.html
	ln -s /usr/lib/${APPNAME}/Help/html html
}

pkg_postinst() {
	einfo "ROX-CLib has been installed into /usr/lib/ROX-CLib"
	einfo "With version 2.1.7, function names have begun to change, but"
	einfo "for the time being old function names are preserved and compile"
	einfo "time warnings will be issued. Please see the README for"
	einfo "detailed information as well as the documentation."
}
