# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/channeleditor/channeleditor-1.9.2.ebuild,v 1.1 2007/10/04 16:40:37 zzam Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Editor for VDR channels.conf"
HOMEPAGE="http://renier.re.funpic.de/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}/${PN}"

mainclass() {
	# read Main-Class from MANIFEST.MF
	sed -n "s/^Main-Class: \([^ ]\+\).*/\1/p" "${S}/MANIFEST.MF"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# move files out of build and remove stuff not needed in the package
	mv build/* "${S}"
	rm -f src/java/org/javalobby/icons/{README,COPYRIGHT}

	# copy build.xml
	cp -f "${FILESDIR}/build.xml" build.xml

	# convert CRLF to LF
	edos2unix MANIFEST.MF
}

src_compile() {
	eant build -Dmanifest.mainclass=$(mainclass)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	java-pkg_dolauncher ${PN} --main $(mainclass)

	make_desktop_entry channeleditor Channeleditor "" "Utility" || \
		die "Couldn't make ttcut desktop entry"
}
