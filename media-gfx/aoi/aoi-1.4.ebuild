# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/aoi/aoi-1.4.ebuild,v 1.1 2003/05/15 09:34:25 absinthe Exp $

inherit java-pkg

At="artofillusion14.zip"
S="${WORKDIR}/ArtOfIllusion1.4"
DESCRIPTION="A free, open-source 3D modelling and rendering studio."
SRC_URI="mirror://sourceforge/${PN}/${At}
	doc? ( http://aoi.sourceforge.net/docs/downloads/manual.zip )"
HOMEPAGE="http://aoi.sourceforge.net/index"
KEYWORDS="x86 ppc sparc alpha mips hppa"
LICENSE="GPL-2"
SLOT="0"
DEPEND=""
RDEPEND=">=virtual/jdk-1.2
	quicktime? ( dev-java/jmf )"
IUSE="doc quicktime"

src_unpack() {
	cd ${WORKDIR}
	unpack ${At}
	use doc && unpack manual.zip
}
src_compile() {
	einfo " This ebuild is binary-only (for now)."
	einfo " If you get this to compile from source, please file a bug"
	einfo " and let us know.  http://bugs.gentoo.org/"
}

src_install() {
	use quicktime && DEP_APPEND="jmf"
	dobin ${FILESDIR}/aoi
	dodoc HISTORY LICENSE README
	if [ -n "`use doc`" ] ; then
		mv ${WORKDIR}/AoI\ Manual/ ${WORKDIR}/aoi_manual/
		dohtml -r ${WORKDIR}/aoi_manual/
	fi
	java-pkg_dojar ArtOfIllusion.jar 
	JARDESTTREE="lib/Plugins"
	java-pkg_dojar Plugins/*.jar
}

