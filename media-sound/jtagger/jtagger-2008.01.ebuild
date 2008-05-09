# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jtagger/jtagger-2008.01.ebuild,v 1.3 2008/05/09 21:00:59 opfer Exp $

EAPI="1"

JAVA_PKG_IUSE="source test"

inherit eutils java-pkg-2

DESCRIPTION="Powerful MP3 tag and filename editor"
HOMEPAGE="http://dronten.googlepages.com/jtagger"
SRC_URI="http://dronten.googlepages.com/${P}.jar.zip"

LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
IUSE=""
SLOT="0"

COMMON_DEP="
	dev-java/jlayer
	dev-java/jid3"
RDEPEND=">=virtual/jre-1.5
	dev-java/jgoodies-looks:2.0
	${COMMON_DEP}"

DEPEND="${COMMON_DEP}
	>=virtual/jdk-1.5
	app-arch/unzip
	test? ( dev-java/junit:0 )"

src_unpack() {
	mkdir -p "${S}/src" || die
	cd "${S}/src" || die

	unpack ${A}
	unzip -q ${P}.jar || die

	rm -vr ${P}.jar com/jgoodies javazoom  org META-INF || die
	find . -name '*.class' -delete || die

	# Move the tests away
	mkdir -p ../test/com/googlepages/dronten/jtagger || die
	mv com/googlepages/dronten/jtagger/test \
		../test/com/googlepages/dronten/jtagger/test || die
}

src_compile() {
	local classpath="$(java-pkg_getjars jid3,jlayer)"

	cd "${S}/src"
	find . -name '*.java' > sources.list
	ejavac -encoding latin1 -cp "${classpath}" @sources.list

	find . -name '*.class' -o -name '*.png' > classes.list
	touch myManifest
	jar cmf myManifest ${PN}.jar @classes.list || die "jar failed"
}

src_test() {
	cd "${S}/test"

	local cp=".:${S}/src/${PN}.jar:$(java-pkg_getjars jid3,jlayer)"
	cp="${cp}:$(java-pkg_getjars --build-only junit)"

	find . -name '*.java' > sources.list
	ejavac -cp "${cp}" @sources.list
	ejunit -cp "${cp}" \
		com.googlepages.dronten.jtagger.test.TestRenameAlbum \
		com.googlepages.dronten.jtagger.test.TestRenameFile \
		com.googlepages.dronten.jtagger.test.TestRenameTitle
}

src_install() {
	java-pkg_dojar src/${PN}.jar
	java-pkg_register-dependency jgoodies-looks-2.0
	java-pkg_dolauncher jtagger --main com.googlepages.dronten.jtagger.JTagger

	use source && java-pkg_dosrc src/com

	newicon src/com/googlepages/dronten/jtagger/resource/jTagger.icon.png ${PN}.png
	make_desktop_entry jtagger "jTagger MP3 tag editor"
}
