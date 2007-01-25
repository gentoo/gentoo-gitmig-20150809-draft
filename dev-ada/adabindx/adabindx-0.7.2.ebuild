# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/adabindx/adabindx-0.7.2.ebuild,v 1.13 2007/01/25 23:31:24 genone Exp $
#

DESCRIPTION="An Ada-binding to the X Window System and *tif."
SRC_URI="http://home.arcor.de/hfvogt/${P}.tar.bz2"
HOMEPAGE="http://home.arcor.de/hfvogt/programming.html"

LICENSE="GMGPL"
RDEPEND="|| ( x11-libs/libXpm virtual/x11 )"
DEPEND="${RDEPEND}
	>=dev-lang/gnat-3.14p
	>=sys-apps/sed-4"
RDEPEND=""
KEYWORDS="x86 ~ppc"
SLOT="0"
IUSE=""

src_unpack() {
	unpack "${P}.tar.bz2"
	cd "${S}"
	bzip2 -cd ${FILESDIR}/${P}.diff.bz2 | patch -p1
	sed -i -e "s/-O3.*/\${ADACFLAGS}/g" Local.conf
}

src_compile() {
	emake || die
}

src_install () {
	dodoc CHANGES COPYING INSTALL README TODO

	insinto /usr/lib/ada/adalib/adabindx
#	chmod 0644 lib/libadabindx.a
#	mv lib/libadabindx.a lib/libadabindx-${PV}.a
	doins lib/libadabindx-${PV}.a
#	dosym /usr/lib/ada/adalib/adabindx/libadabindx-${PV}.a \
#		/usr/lib/ada/adalib/adabindx/libadabindx.a
	doins lib/*.ali

	cd ${D}/usr/lib/ada/adalib/adabindx/
	ln -s libadabindx-${PV}.a libadabindx.a
	cd ${S}

	insinto /usr/lib/ada/adainclude/adabindx
	doins lib/*.ads
	doins lib/*.adb

	#install examples
	cp -r examples ${D}/usr/share/doc/${PF}/

	#set up environment
	dodir /etc/env.d
	echo "ADA_OBJECTS_PATH=/usr/lib/ada/adalib/${PN}" \
		> ${D}/etc/env.d/55adabindx
	echo "ADA_INCLUDE_PATH=/usr/lib/ada/adainclude/${PN}" \
		>> ${D}/etc/env.d/55adabindx
}

pkg_postinst() {
	elog "The envaironment has been set up to make gnat automatically find files for"
	elog "AdaBindX. In order to immediately activate these settings please do:"
	elog "env-update"
	elog "source /etc/profile"
	elog "Otherwise the settings will become active next time you login"
}

