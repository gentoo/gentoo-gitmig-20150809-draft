# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/aqua-data-studio/aqua-data-studio-3.5.ebuild,v 1.2 2004/02/16 20:56:05 mr_bones_ Exp $

DESCRIPTION="An SQL editor and developer tool"
HOMEPAGE="http://www.aquafold.com"
SRC_URI="http://www.aquafold.net/download/linux/adstudio-novm.tar.gz"
LICENSE="aqua-data-studio"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="gnome kde"
RDEPEND="virtual/jre"

S=${WORKDIR}/datastudio

src_install() {
	insinto /opt/${PN}/lib
	doins lib/*

	if [ `use gnome || use kde` ] ; then
		einfo "Adding icon..."
		insinto /opt/${PN}/lib
		doins datastudio.ico
	fi

	if [ `use gnome` ] ; then

		einfo "Adding GNOME support..."
		echo "[Desktop Entry]" > ${PN}.desktop
		echo "Name=Aqua Data Studio" >> ${PN}.desktop
		echo "Comment=${DESCRIPTION}" >> ${PN}.desktop
		echo "Icon=/opt/${PN}/lib/datastudio.ico" >> ${PN}.desktop
		echo "Exec=/opt/bin/${PN}" >> ${PN}.desktop
		echo "Type=Application" >> ${PN}.desktop
		echo "Categories=GNOME;Application;Development" >> ${PN}.desktop

		insinto /usr/share/gnome/apps/Development
		doins ${PN}.desktop
	fi

	if [ `use kde` ] ; then
		einfo "Adding KDE support..."
		echo "Name=Aqua Data Studio" > ${PN}-kde.desktop
		echo "Exec=/opt/bin/${PN}" >> ${PN}-kde.desktop
		echo "Icon=/opt/${PN}/lib/datastudio.ico" >> ${PN}-kde.desktop
		echo "Type=Application" >> ${PN}-kde.desktop
		insinto ${KDEDIR}/share/applnk/Development
		doins ${PN}-kde.desktop
	fi

	# Make my own wrapper
	local my_classes
	for i in lib/*.jar ; do
		my_classes=${my_classes}:$i
	done

	echo "#!/bin/sh" > ${PN}
	echo "cd /opt/${PN}" >> ${PN}
	echo '${JAVA_HOME}'/bin/java -cp ${my_classes} com.aquafold.datastudio.DataStudio '$*' >> ${PN}

	into /opt
	dobin ${PN}

	dodoc changelog.txt
}
