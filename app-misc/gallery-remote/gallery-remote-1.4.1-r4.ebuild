# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gallery-remote/gallery-remote-1.4.1-r4.ebuild,v 1.2 2007/06/04 08:04:04 opfer Exp $

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Gallery Remote is a client-side Java application that provides users with a rich front-end to Gallery. This application makes it easier to upload images to your Gallery."
HOMEPAGE="http://gallery.sourceforge.net/gallery_remote.php"
SRC_URI="mirror://gentoo/gallery-remote-${PV}-cvs-gentoo.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""
RDEPEND=">=virtual/jre-1.4
		dev-java/apple-java-extensions-bin
		>=dev-java/metadata-extractor-2.2.2-r1
		media-gfx/imagemagick
		media-libs/jpeg"
DEPEND=">=virtual/jdk-1.4
		dev-java/ant-core
		${RDEPEND}"

S="${WORKDIR}/gallery_remote"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}.patch" "${FILESDIR}/${P}-ant.patch"
	cd "${S}/lib"
	rm -f *.jar
	java-pkg_jar-from apple-java-extensions-bin AppleJavaExtensions.jar
	java-pkg_jar-from metadata-extractor metadata-extractor.jar metadata-extractor-2.1.jar
	java-pkg_jar-from --build-only ant-core ant.jar
}

src_compile() {
	eant jar
}

src_install() {
	dodoc ChangeLog README
	java-pkg_dojar GalleryRemote.jar

	dodir /usr/share/gallery-remote/{imagemagick,jpegtran}
	cp imagemagick/im.properties.preinstalled ${D}/usr/share/gallery-remote/imagemagick/im.properties
	cp jpegtran/jpegtran.preinstalled ${D}/usr/share/gallery-remote/jpegtran/jpegtran.properties
	cp -r img ${D}/usr/share/gallery-remote/

	java-pkg_addcp './img/'
	#echo "#!/bin/bash" > gallery-remote
	#echo "cd /usr/share/gallery-remote/" >> gallery-remote
	#echo "java -cp \$(java-config -p ${PN},metadata-extractor):img/ com.gallery.GalleryRemote.GalleryRemote \${@} "  >> gallery-remote
	#dobin gallery-remote
	java-pkg_dolauncher gallery-remote \
		--main com.gallery.GalleryRemote.GalleryRemote \
		--pwd /usr/share/gallery-remote
}
