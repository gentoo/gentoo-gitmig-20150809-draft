# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/poseidonCE/poseidonCE-2.4.1.ebuild,v 1.5 2004/11/03 11:42:22 axxo Exp $

IUSE="doc gnome kde"
DESCRIPTION="A UML CASE-Tool powered by Java"
SRC_URI="${P}.zip"
HOMEPAGE="http://www.gentleware.com/"
LICENSE="PoseidonCommon.pdf"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~amd64"
RDEPEND=">=virtual/jdk-1.4.1"
DEPEND="app-arch/unzip"
RESTRICT="fetch"

pkg_nofetch() {
	einfo "Please visit ${HOMEPAGE} and download Poseidon Community Edition:"
	einfo "     ${SRC_URI}"
	einfo "Save it in ${DISTDIR} !"
}

src_install() {
	insinto /opt/${PN}/lib
	doins lib/*.jar

	echo "#!/bin/sh" > ${PN}
	echo "cd /opt/${PN}" >> ${PN}
	echo '${JAVA_HOME}'/bin/java -cp lib/floating-server.jar:lib/poseidon.jar:lib/umlplugin.jar:${JAVA_HOME}/jre/lib/rt.jar \
	      -Xms64m -Xmx160m -Dposeidon.java.home="${JAVA_HOME}" -Dposeidon.user.dir.PE="$POSEIDONPE_HOME" \
		  com.gentleware.poseidon.Poseidon '$*' >> ${PN}

	into /opt
	dobin ${PN}

	if use doc ; then
		dohtml -r docs/*
		dosym /usr/share/doc/${P}/html/ /opt/${PN}/docs

		insinto /usr/share/doc/${P}
		doins docs/PoseidonUsersGuide.pdf
	fi

	if use gnome || use kde; then
		einfo "Adding icons..."
		insinto /opt/${PN}/lib
		doins bin/poseidon.ico
	fi

	if use gnome ; then

		einfo "Adding GNOME support..."
		echo "[Desktop Entry]" > ${PN}.desktop
		echo "Name=${PN}" >> ${PN}.desktop
		echo "Comment=${DESCRIPTION}" >> ${PN}.desktop
		echo "Icon=/opt/${PN}/lib/poseidon.ico" >> ${PN}.desktop
		echo "Exec=/opt/bin/${PN}" >> ${PN}.desktop
		echo "Type=Application" >> ${PN}.desktop
		echo "Categories=GNOME;Application;Development" >> ${PN}.desktop

		insinto /usr/share/gnome/apps/Development
		doins ${PN}.desktop
	fi

	if use kde ; then
		einfo "Adding KDE support..."
		echo "Name=PoseidonCE" > ${PN}-kde.desktop
		echo "Exec=/opt/bin/${PN}" >> ${PN}-kde.desktop
		echo "Icon=/opt/${PN}/lib/poseidon.ico" >> ${PN}-kde.desktop
		echo "Type=Application" >> ${PN}-kde.desktop
		insinto ${KDEDIR}/share/applnk/Development
		doins ${PN}-kde.desktop
	fi

	dodoc LICENSE.txt

	dodir /opt/${PN}/examples
	cp -R examples/* ${D}opt/${PN}/examples
}
