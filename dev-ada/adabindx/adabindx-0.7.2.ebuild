# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/adabindx/adabindx-0.7.2.ebuild,v 1.2 2003/09/08 07:20:54 msterret Exp $
#

DESCRIPTION="An Ada-binding to the X Window System and *tif."
SRC_URI="http://home.arcor.de/hfvogt/${P}.tar.bz2"
HOMEPAGE="http://home.arcor.de/hfvogt/programming.html"

LICENSE="GMGPL"
DEPEND="dev-lang/gnat
	virtual/x11"
RDEPEND=""
KEYWORDS="~x86"
SLOT="0"
IUSE=""

inherit gnat

src_unpack() {
	unpack "${P}.tar.bz2"
	cd "${S}"
	patch -p1 < ${FILESDIR}/${P}.diff
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
}

