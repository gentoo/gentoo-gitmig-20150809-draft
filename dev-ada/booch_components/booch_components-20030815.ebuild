# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/booch_components/booch_components-20030815.ebuild,v 1.2 2003/10/28 13:22:16 dholm Exp $

IUSE=""

inherit gnat

Name="bc"
S="${WORKDIR}/${Name}-${PV}"
DESCRIPTION="Booch Components for ada"
SRC_URI="http://www.pogner.demon.co.uk/components/${Name}/download/${Name}-${PV}.tgz
	http://www.pogner.demon.co.uk/components/${Name}/download/${Name}-html-${PV}.zip"

HOMEPAGE="http://www.pogner.demon.co.uk/components/bc/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
SLOT="0"

DEPEND=">=dev-lang/gnat-3.14p"

src_compile() {
	make clean && make all
	#need to force at least some basic compilation
	cd test
	emake || die
}

src_install () {
	#makefile does not do much, so we need to install stuff manually
	dodir /usr/lib/ada/adalib/${PN} /usr/lib/ada/adainclude/${PN}
	cd ${S}/test
	cp -a *.{o,ali} ${D}/usr/lib/ada/adalib/${PN}
	cd ${S}
	cp *.ad? ${D}/usr/lib/ada/adainclude/${PN}

	# Install documentation.
	dodoc COPYING README
	cd ${WORKDIR}
	dohtml *
	cp coldframe-hash.* x.ada ${D}/usr/share/doc/${PF}/html

	cd ${S}
	cp -r demo ${D}/usr/share/doc/${PF}/

	dodir /usr/share/doc/${PF}/test
	cd test
	cp *.ad? *.dat makefile ${D}/usr/share/doc/${PF}/test

	#set up environment
	dodir /etc/env.d
	echo "ADA_OBJECTS_PATH=/usr/lib/ada/adalib/${PN}" > ${D}/etc/env.d/55booch_components
	echo "ADA_INCLUDE_PATH=/usr/lib/ada/adainclude/${PN}" >> ${D}/etc/env.d/55booch_components
}

pkg_postinst(){
	einfo "The envaironment has been set up to make gnat automatically find files in"
	einfo "Booch components. In order to immediately activate these settings please do"
	einfo "env-update"
	einfo "source /etc/profile"
	einfo "Otherwise the settings will become active next time you login"
}
