# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xindice/xindice-1.0.ebuild,v 1.2 2003/04/25 15:15:04 vapier Exp $

inherit eutils

DESCRIPTION="A native java XML database"
HOMEPAGE="http://xml.apache.org/xindice"
SRC_URI="http://xml.apache.org/xindice/dist/xml-xindice-${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=">=dev-java/sun-jdk-1.3"

S=${WORKDIR}/xml-${P}

pkg_preinst() {
	enewgroup xindice || die "Adding group xindice failed"
	enewuser xindice -1 /bin/sh /var/run/xindice xindice || die "Adding user xindice failed"
	ewarn "This has only been tested with Sun's JDK!"
	ewarn "Good luck if you use another VM"
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	export XINDICE_HOME=${S}
	bin/ant
	use doc && bin/ant docs
}

src_install() {
	export TARGET=/opt/xindice
	keepdir /var/run/xindice
	chown xindice.xindice ${D}/var/run/xindice
	dodir ${TARGET}
	dodir ${TARGET}/java
	cp -Rvdp bin config icons docs logs idl ${D}${TARGET}
	cd java 
	cp -Rvdp lib tests examples ${D}${TARGET}/java
 	cd ..
	dodoc docs/LICENSE docs/README docs/FAQ docs/TODO docs/VERSIONS docs/AUTHORS
	dohtml docs/AdministratorsGuide.html docs/DevelopersGuide.html docs/UsersGuide.html docs/ToolsReference.html docs/feather.gif docs/index.html docs/xindice.jpg
	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/21xindice
	dodir /etc/init.d
	insinto /etc/init.d
	insopts -m0755
	doins ${FILESDIR}/xindice	
	insinto ${TARGET}
	doins start
	keepdir /opt/xindice/db
	chown -R xindice.xindice ${D}/opt/xindice	
}
