# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/XWine/XWine-0.2.2.ebuild,v 1.7 2003/03/13 11:57:55 phoenix Exp $

DESCRIPTION="GTK frontend for Wine"
HOMEPAGE="http://darken.tuxfamily.org/pages/xwine_en.html"
SRC_URI="http://darken.tuxfamily.org/projets/${P}_en.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc "
IUSE="nls gnome"

DEPEND=">=x11-libs/gtk+-1.2.10-r8
	>=net-www/mozilla-1.0-r2
	>=app-emulation/wine-20020710-r1
	sys-devel/bison
	>=gnome-base/gnome-libs-1.4.2 
	>=gnome-base/ORBit-0.5.17
	nls? ( sys-devel/gettext )"
RDEPEND="${DEPEND}
	>=app-emulation/winesetuptk-0.6.0b-r2"

S="${WORKDIR}/${P}_en"

src_compile() {
	local myconf

	use nls && myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	MOZ="`which mozilla`"

	if [ -f ${MOZ} ] ; then
		einfo "Setting up src/donnees.h to use mozilla as help browser."
		cp -f ${S}/configure.d ${S}/configure
		cp -f ${S}/src/donnees.h.in ${S}/src/donnees.h
		echo "#define NAVIGATEUR \"${MOZ} -f\"" >> ${S}/src/donnees.h
	else
		ewarn "Mozilla not found in current PATH."
		ewarn "PATH = ${PATH}"
		die "Mozilla not found."
	fi


	econf ${myconf}

	emake || die
}

src_install() {
	einstall

	# Don't need to install docs twice
	rm -rf ${D}/usr/share/doc/xwine

	dodoc doc/Manual* FAQ* BUGS COPYING AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	einfo "${PN} requires a setup Wine to start....It is recommended"
	einfo "that you run winesetuptk prior to running ${PN} to setup"
	einfo "a base Wine install"
}
