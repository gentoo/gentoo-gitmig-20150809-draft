# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aoi/aoi-1.6.ebuild,v 1.5 2004/03/26 10:51:46 dholm Exp $

inherit java-pkg

MY_P="AoIsrc16"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="A free, open-source 3D modelling and rendering studio."
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip
	doc? ( http://aoi.sourceforge.net/docs/downloads/manual.zip )"
HOMEPAGE="http://aoi.sourceforge.net/index"
KEYWORDS="~x86 ~sparc"
LICENSE="GPL-2"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jdk-1.2
	dev-java/jmf
	dev-java/ant"
IUSE="doc"

src_unpack() {
	cd ${WORKDIR}
	unpack ${MY_P}.zip
	use doc && unpack manual.zip
}
src_compile() {

	export CLASSPATH="/usr/share/jmf/lib/jmf.jar"

	ant -buildfile ArtOfIllusion.xml || die "Building ArtOfIllusion failed"
	ant -buildfile OSSpecific.xml || die "Building OSSpecific failed"
	ant -buildfile Renderers.xml || die "Building Renderers failed"
	ant -buildfile Tools.xml || die "Building Tools failed"
	ant -buildfile Translators.xml || die "Building Translators failed"
}

src_install() {
	DEP_APPEND="jmf"
	dobin ${FILESDIR}/aoi
	dodoc HISTORY LICENSE README-source
	if [ -n "`use doc`" ] ; then
		mv ${WORKDIR}/AoI\ Manual/ ${WORKDIR}/aoi_manual/
		dohtml -r ${WORKDIR}/aoi_manual/
	fi
	java-pkg_dojar ArtOfIllusion.jar
	JARDESTTREE="lib/Plugins"
	java-pkg_dojar Plugins/*.jar
}
