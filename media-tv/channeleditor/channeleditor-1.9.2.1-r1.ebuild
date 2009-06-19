# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/channeleditor/channeleditor-1.9.2.1-r1.ebuild,v 1.1 2009/06/19 17:39:11 billie Exp $

EAPI="2"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Editor for VDR channels.conf"
HOMEPAGE="http://renier.re.funpic.de/"
SRC_URI="mirror://sourceforge/${PN}/${P/-/_}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="java5 java6 source"

RDEPEND="java6? ( >=virtual/jre-1.6 )
	!java6? ( java5? ( >=virtual/jre-1.5 ) )
	!java6? ( !java5? ( >=virtual/jre-1.4 ) )"

DEPEND="java6? ( >=virtual/jdk-1.6 )
	!java6? ( java5? ( >=virtual/jdk-1.5 ) )
	!java6? ( !java5? ( >=virtual/jdk-1.4 ) )
	source? ( app-arch/zip )"

S="${WORKDIR}/${PN}"

mainclass() {
	# read Main-Class from MANIFEST.MF
	sed -n "s/^Main-Class: \([^ ]\+\).*/\1/p" "${S}/MANIFEST.MF" \
	|| die "reading Main-Class failed"
}

src_prepare() {
	# move files out of build and remove stuff not needed in the package
	mv build/* "${S}" || die "cleaning build dir failed"
	rm -f src/java/org/javalobby/icons/{README,COPYRIGHT} \
		|| die "removing files failed"

	# copy build.xml
	if use java6; then
		sed 's:\(value=\"\)1\.4\(\"\):\11.6\2:g' \
			"${FILESDIR}/build-${PV}.xml" > build.xml \
			|| die "copying build.xml failed"
	elif use java5; then
		sed 's:\(value=\"\)1\.4\(\"\):\11.5\2:g' \
			"${FILESDIR}/build-${PV}.xml" > build.xml \
			|| die "copying build.xml failed"
	else
		cp -f "${FILESDIR}/build-${PV}.xml" build.xml \
			|| die "copying build.xml failed"
	fi

	# convert CRLF to LF
	edos2unix MANIFEST.MF

	# include localisation changes
	epatch "${FILESDIR}"/${P}-messages.properties.patch
	epatch "${FILESDIR}"/${P}-messages_en.properties.patch
}

src_compile() {
	eant build -Dmanifest.mainclass=$(mainclass)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	java-pkg_dolauncher ${PN} --main $(mainclass)

	use source && java-pkg_dosrc src

	make_desktop_entry channeleditor Channeleditor "" "Utility"
}
