# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-cdt/eclipse-cdt-2.0-r2.ebuild,v 1.6 2004/11/25 13:51:32 karltk Exp $

inherit eclipse-ext

DESCRIPTION="Eclipse C/C++ Development Tools"
HOMEPAGE="http://www.eclipse.org/cdt"
SRC_URI="http://dev.gentoo.org/~karltk/projects/eclipse/distfiles/eclipse-cdt-2.0-gentoo-1.tar.bz2"
LICENSE="CPL-1.0"
SLOT="2"
KEYWORDS="-* ~x86"
IUSE=""
DEPEND="=dev-util/eclipse-sdk-3.0.0*"

# karltk: A lot more work to do:
# - add back other arches

src_unpack() {
	unpack ${A}
	cd ${S}
	mkdir -p ${S}/results/eclipse-copy
	(
		cd ${S}/results/eclipse-copy
		lndir -silent /usr/lib/eclipse-3
		# getProtectionDomain().getCodeSource() my buttocks...
		rm startup.jar ; cp /usr/lib/eclipse-3/startup.jar .
	)
	mkdir -p ${S}/results/final-result
	touch ${S}/results/final-result/compilelog.txt

	sed -e "s/name=\"buildId\" value=\"[^\"]*\"/name=\"buildId\" value=\"${P}_gentoo\"/" \
		-e 's:name="zipsdir" value="[^"]*":name="zipsdir" value="${buildDirectory}/final-result":' \
		-i build.xml

	sed -e "s:ECLIPSE_HOME=.*:ECLIPSE_HOME=${S}/results/eclipse-copy:" \
		-i build.sh

	sed -e "s:buildLabel=.*:buildLabel=final-result:" \
		-i platform/build.properties \
		-i sdk/build.properties
}

src_compile() {
	# Use java-utils
	addwrite /proc/cpuinfo
	einfo "Building native code"
	(
		cd results/plugins/org.eclipse.cdt.core.linux/library || die
		make ARCH=x86 all || die "Failed to compile platform-specific code"
	)
	einfo "Building Java code"
	./build.sh || die "Failed to compile"

	finalzip=results/final-result/org.eclipse.cdt-2.1.0-eclipse-cdt-2.0_gentoo-linux.x86.zip
	if [ ! -f ${finalzip} ] ; then
		die "Compilation of final SDK zip failed"
	fi

	unzip ${finalzip} -d results/final-result/
}

src_install() {
	eclipse-ext_require-slot 3

	eclipse-ext_create-ext-layout source

	eclipse-ext_install-features results/final-result/eclipse/features/*
	eclipse-ext_install-plugins results/final-result/eclipse/plugins/*
}

