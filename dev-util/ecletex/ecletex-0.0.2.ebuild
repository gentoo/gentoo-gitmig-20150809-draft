# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ecletex/ecletex-0.0.2.ebuild,v 1.5 2004/11/03 11:46:07 axxo Exp $

DESCRIPTION="LaTeX plugin for Eclipse 3.0 and newer"
HOMEPAGE="http://etex.sf.net"
SRC_URI="mirror://sourceforge/etex/${PN}.${PV}.Source.zip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=virtual/jdk-1.4
	=dev-util/eclipse-sdk-3.0*
	app-arch/unzip"

src_unpack() {
	unpack ${A}

	mv ecletex ${P}

	ln -s /usr/lib/eclipse-3/plugins ${S}/ext

	echo "temp.folder=dist" > ${S}/build.properties || die "Failed to create build.propertes"

	cp ${FILESDIR}/build.xml-${PV} ${S}/build.xml || die "Failed to add build.xml"
}

src_compile() {
	ant build.jars || die "Failed to build main plugin"
	ant ecletexsrc.zip || die "Failed to build source .zip"
}

src_install() {
	local etexdir="/usr/lib/eclipse-3/plugins/ish.ecletex_${PV}"
	dodir ${etexdir}

	insinto ${etexdir}
	doins ecletexsrc.zip || die "Failed to install source"
	doins ecletex.jar || die "Failed to install main plugin"
	doins plugin.xml || die "Failed to install plugin.xml"

	for x in codeassist dictionary icons templates ; do
		cp -dpR $x ${D}/${etexdir}/ || die "Failed to install directory $x"
	done
}
