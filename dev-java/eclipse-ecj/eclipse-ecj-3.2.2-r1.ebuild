# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/eclipse-ecj/eclipse-ecj-3.2.2-r1.ebuild,v 1.3 2008/12/20 18:33:54 maekke Exp $

inherit eutils java-pkg-2

DESCRIPTION="Eclipse Compiler for Java"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="EPL-1.0"
KEYWORDS="amd64 ~ia64 ppc ~ppc64 x86 ~x86-fbsd"
SLOT="3.2"
IUSE="doc"

RDEPEND=">=virtual/jre-1.4
	app-admin/eselect-ecj"
DEPEND="${RDEPEND}
	>=virtual/jdk-1.4
	dev-java/ant-core"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# remove unzip, add javadoc target, put final ecj.jar and javadocs in dist/ and not ../
	epatch "${FILESDIR}/${PN}-${SLOT}-build-gentoo.patch"
}

src_compile() {
	# we don't use eant because the compile*.xml files specifically set -source -target and used compiler

	# bootstrap build with JDK's javac
	ant -f compilejdtcorewithjavac.xml || die "Failed to bootstrap build with javac"

	local ant_flags=""

	# for some weird reason, with kaffe it fails the build.xml's check for ecj.jar present (which it is)
	# which if successful sets this property, then checks if it was set and fails if not
	java-pkg_current-vm-matches kaffe && ant_flags="-Dbuild.compiler=org.eclipse.jdt.core.JDTCompilerAdapter"

	# recompile with ecj.jar made in first step, to get dist/ecj.jar
	ant ${ant_flags} -lib ecj.jar -f compilejdtcore.xml compile $(use_doc) || die "Failed to rebuild with ecj"
}

src_install() {
	java-pkg_dojar dist/ecj.jar

	java-pkg_dolauncher ecj-${SLOT} --main org.eclipse.jdt.internal.compiler.batch.Main

	use doc && java-pkg_dojavadoc dist/doc/api

	insinto /usr/share/java-config-2/compiler
	newins "${FILESDIR}"/compiler-settings-${SLOT} ecj-${SLOT}
}

pkg_postinst() {
	einfo "To select between slots of ECJ..."
	einfo " # eselect ecj"

	eselect ecj update ecj-${SLOT}
}

pkg_postrm() {
	eselect ecj update
}
