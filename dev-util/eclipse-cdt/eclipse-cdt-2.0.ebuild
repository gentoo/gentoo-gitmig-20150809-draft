# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-cdt/eclipse-cdt-2.0.ebuild,v 1.4 2004/07/29 20:00:50 mr_bones_ Exp $

inherit eclipse-ext

DESCRIPTION="Eclipse C/C++ Development Tools"
HOMEPAGE="http://www.eclipse.org/cdt"
SRC_URI="http://dev.gentoo.org/~karltk/projects/eclipse/distfiles/eclipse-cdt-2.0-gentoo.tar.gz"
LICENSE="CPL-1.0"
SLOT="2"
KEYWORDS="-* ~x86"
IUSE=""
DEPEND=">=dev-util/eclipse-sdk-3.0.0"
S=${WORKDIR}/${P}

# karltk: A lot more work to do:
# - make a better snapshot of the CVS
# - remove the the CVS connects during build!
# - fix the unzip hack
# - use eclipse-ext
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
	sed -e "s/name=\"buildId\" value=\"[^\"]*\"/name=\"buildId\" value=\"${P}_gentoo\"/" \
		-e 's_name="zipsdir" value="[^"]*"_name="zipsdir" value="${buildDirectory}/final-result"_' \
		-i build.xml
}

src_compile() {
	# Use java-utils
	addwrite /proc/cpuinfo
	(
		cd results/plugins/org.eclipse.cdt.core.linux/library || die
		make ARCH=x86 all || die "Failed to compile platform-specific code"
	)
	./build.sh || die "Failed to compile"
}

src_install() {
	if [ ! -f results/I.eclipse-cdt-2.0_gentoo/org.eclipse.cdt-2.1.0-eclipse-cdt-2.0_gentoo-linux.x86.zip ] ; then
		die "Compilation of final SDK zip failed"
	fi

	dodir /usr/lib/eclipse-3

	# Nasty!
	unzip results/I.eclipse-cdt-2.0_gentoo/org.eclipse.cdt-2.1.0-eclipse-cdt-2.0_gentoo-linux.x86.zip \
		-d ${D}/usr/lib/eclipse-3
	mv ${D}/usr/lib/eclipse-3/eclipse/{features,plugins} ${D}/usr/lib/eclipse-3
	rmdir ${D}/usr/lib/eclipse-3/eclipse
}

