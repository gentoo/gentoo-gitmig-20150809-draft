# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/jaxodraw/jaxodraw-1.3.2.ebuild,v 1.6 2008/05/12 08:51:23 nelchael Exp $

JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-trax"

inherit java-pkg-2 java-ant-2 versionator eutils

MY_PV=$(replace_version_separator 2 -)

DESCRIPTION="Java program for drawing Feynman diagrams"
HOMEPAGE="http://jaxodraw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="latex"

DEPEND=">=virtual/jdk-1.4
	latex? ( virtual/latex-base )"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/JaxoDraw-${MY_PV}"

src_install() {

	cd "${S}"

	java-pkg_newjar ${PN}-${MY_PV}.jar ${PN}.jar

	doicon etc/OS/Linux/*.png
	domenu etc/OS/Linux/${PN}.desktop

	use source && java-pkg_dosrc src/java/JaxoDraw

	dodoc doc/BUGS doc/CHANGELOG doc/README doc/TODO || die
	doman doc/man/${PN}.1
	use doc && java-pkg_dojavadoc build/javadoc

	java-pkg_dolauncher "${PN}" --main JaxoDraw.JaxoDraw

	if use latex; then
		dodir /usr/share/texmf/tex/latex/misc/
		insinto /usr/share/texmf/tex/latex/misc/
		doins "${S}/etc/axodraw.sty"
	fi

}

tex_regen() {
	if use latex; then
		einfo "Regenerating TeX database..."
		/usr/bin/mktexlsr /usr/share/texmf /var/spool/texmf > /dev/null
		eend $?
	fi
}

pkg_postinst() {
	tex_regen
}

pkg_postrm() {
	tex_regen
}
