# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gallery-remote/gallery-remote-1.4.1.ebuild,v 1.5 2005/07/11 20:27:59 axxo Exp $

inherit java-pkg eutils

DESCRIPTION="Gallery Remote is a client-side Java application that provides users with a rich front-end to Gallery. This application makes it easier to upload images to your Gallery."
HOMEPAGE="http://gallery.sourceforge.net/gallery_remote.php"
SRC_URI="mirror://gentoo/gallery-remote-${PV}-cvs-gentoo.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="jikes"
RDEPEND=">=virtual/jre-1.4
		dev-java/apple-java-extensions-bin
		dev-java/metadata-extractor
		media-gfx/imagemagick
		media-libs/jpeg"
DEPEND=">=virtual/jdk-1.4
		${RDEPEND}
		jikes? ( dev-java/jikes )"

S=${WORKDIR}/gallery_remote

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}.patch
	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from apple-java-extensions-bin AppleJavaExtensions.jar
	java-pkg_jar-from metadata-extractor metadata-extractor.jar metadata-extractor-2.1.jar
}

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	ant ${antflags} || die "failed to compile"
}

src_install() {
	dodoc ChangeLog README
	java-pkg_dojar GalleryRemote.jar

	dodir /usr/share/gallery-remote/{imagemagick,jpegtran}
	cp imagemagick/im.properties.preinstalled ${D}/usr/share/gallery-remote/imagemagick/im.properties
	cp jpegtran/jpegtran.preinstalled ${D}/usr/share/gallery-remote/jpegtran/jpegtran.properties
	cp -r img ${D}/usr/share/gallery-remote/

	echo "#!/bin/bash" > gallery-remote
	echo "cd /usr/share/gallery-remote/" >> gallery-remote
	echo "java -jar lib/GalleryRemote.jar"  >> gallery-remote
	dobin gallery-remote
}
