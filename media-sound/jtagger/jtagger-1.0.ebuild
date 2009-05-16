# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jtagger/jtagger-1.0.ebuild,v 1.1 2009/05/16 23:06:11 serkan Exp $

EAPI="2"

JAVA_PKG_IUSE="source test"

inherit eutils java-pkg-2

DESCRIPTION="Powerful MP3 tag and filename editor"
HOMEPAGE="http://dronten.googlepages.com/jtagger"
SRC_URI="http://dronten.googlepages.com/${PN}.zip -> ${P}.zip"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

COMMON_DEP="
	dev-java/jlayer
	>=dev-java/jid3-0.46-r1"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

DEPEND="${COMMON_DEP}
	>=virtual/jdk-1.5
	app-arch/unzip"

src_unpack() {
	mkdir -p "${S}/src" || die
	cd "${S}/src" || die

	unpack ${A}
	unzip -q ${PN}.jar || die

	# Fix for bug #231571 comment #2. This removes real @Override annotations but safer.
	sed -i -e "s/@Override//g" $(find . -name "*.java") || die "failed fixing for Java 5."

	rm -vr ${PN}.jar javazoom  org META-INF || die
	find . -name '*.class' -delete || die
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

src_install() {
	java-pkg_dojar src/${PN}.jar
	java-pkg_dolauncher jtagger --main com.googlepages.dronten.jtagger.JTagger

	use source && java-pkg_dosrc src/com

	newicon src/com/googlepages/dronten/jtagger/resource/jTagger.icon.png ${PN}.png
	make_desktop_entry jtagger "jTagger MP3 tag editor"
}
