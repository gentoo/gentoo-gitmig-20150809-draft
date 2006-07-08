# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-j2me-bin/sun-j2me-bin-2.2-r2.ebuild,v 1.2 2006/07/08 14:30:09 nelchael Exp $

inherit java-pkg-2

DESCRIPTION="Java 2 Micro Edition Wireless Toolkit for developing wireless applications"
HOMEPAGE="http://java.sun.com/products/j2mewtoolkit/"
BINARY="j2me_wireless_toolkit-${PV//./_}-linux-i386.bin"
PATCH="j2me_wireless_toolkit-2_2-update_1-linux.zip"
SRC_URI="${BINARY} ${PATCH}"
LICENSE="sun-bcla-j2me"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc examples"
RESTRICT="fetch"
# Before going official with this all the jars should be checked for packed stuff
# I think the lib/jsrXXX.jar probably are at least packed jars
DEPEND=">=dev-java/sun-jaf-bin-1.0
		>=dev-java/sun-javamail-bin-1.3
		dev-java/xsdlib"
RDEPEND="${DEPEND}
		>=virtual/jdk-1.4.2"

S=${WORKDIR}

MY_FILE=${DISTDIR}/${BINARY}

pkg_nofetch() {

	einfo "Please download ${BINARY} and the patch"
	einfo "${PATCH} from:"
	einfo "http://java.sun.com/products/sjwtoolkit/download-2_2.html"
	einfo "and move it to ${DISTDIR}"

}

src_unpack() {

	if [[ ! -r ${MY_FILE} ]]; then

		eerror "cannot read ${A}. Please check the permission and try again."
		die

	fi

	#extract compressed data and unpack
	ebegin "Unpacking ${BINARY}"
	dd bs=2048 if=${MY_FILE} of=install.zip skip=10 2>/dev/null || die
	unzip install.zip >/dev/null || die
	eend $?
	rm install.zip

	unpack ${PATCH}

	#Set the java-bin-path in some scripts
	for file in ktoolbar emulator mekeytool prefs utils wscompile defaultdevice; do
		sed -i -e \
			"s@pathtowtk=\$@pathtowtk=\`java-config --jdk-home\`\"/bin/\"@" \
			${WORKDIR}/bin/${file} || die
	done

	cd ${S}/bin
	rm -f activation.jar mail.jar xsdlib.jar

}

src_install() {

	local DIR=/opt/${P}
	cd ${WORKDIR}

	einfo "Copying files"
	dodir ${DIR}
	cp -r appdb bin lib wtklib ${D}/${DIR}
	use examples && cp -r apps ${D}/${DIR}

	einfo "Setting permissions"
	chmod 755 ${D}/${DIR}/bin/* || die
	chmod 644 ${D}/${DIR}/bin/*.jar || die

	einfo "Installing documentation"
	dohtml *.html
	use doc && java-pkg_dohtml -r docs/*

	cd ${D}/${DIR}/bin
	java-pkg_jar-from sun-jaf-bin activation.jar
	java-pkg_jar-from sun-javamail-bin mail.jar
	java-pkg_jar-from xsdlib xsdlib.jar

	einfo "Registering jar files"
	java-pkg_regjar \
		${D}${DIR}/lib/*.jar \
		${D}${DIR}/wtklib/kenv.zip \
		${D}${DIR}/wtklib/*.jar

	dodir /usr/bin
	dosym ${DIR}/bin/ktoolbar /usr/bin/ktoolbar

}
