# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/adabindx/adabindx-0.7.2-r1.ebuild,v 1.1 2005/02/23 17:36:44 dholm Exp $
#

inherit eutils gnat

DESCRIPTION="An Ada-binding to the X Window System and *tif."
SRC_URI="http://home.arcor.de/hfvogt/${P}.tar.bz2"
HOMEPAGE="http://home.arcor.de/hfvogt/programming.html"

LICENSE="GMGPL"
DEPEND=">=dev-lang/gnat-3.14p
	virtual/x11
	>=sys-apps/sed-4"
RDEPEND=""
KEYWORDS="~x86 ~ppc"
SLOT="0"
IUSE=""

src_unpack() {
	unpack "${P}.tar.bz2"
	cd "${S}"
	bzip2 -cd ${FILESDIR}/${P}.diff.bz2 | patch -p1
	sed -i -e "s/-O3.*/\${ADACFLAGS}/g" Local.conf
	sed -i -e "s/Elmt_Size : size_t/Elmt_Size : constant size_t/" lib/i-csstli.adb
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
	einfo "The envaironment has been set up to make gnat automatically find files for"
	einfo "AdaBindX. In order to immediately activate these settings please do:"
	einfo "env-update"
	einfo "source /etc/profile"
	einfo "Otherwise the settings will become active next time you login"
}

