# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ikvm/ikvm-0.36.0.5.ebuild,v 1.2 2008/01/02 21:46:51 jurek Exp $

inherit eutils mono multilib

CLASSPATH_P="classpath-0.95"

ECJ_V=3.2.2
ECJ_DATESTAMP=200702121330

DESCRIPTION="Java VM for .NET"
HOMEPAGE="http://www.ikvm.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip
		 mirror://sourceforge/${PN}/classpath-0.95-stripped.zip
		 mirror://sourceforge/${PN}/openjdk-b13-stripped.zip"
LICENSE="as-is"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1"
DEPEND="${RDEPEND}
		!dev-dotnet/ikvm-bin
		>=dev-dotnet/nant-0.85
		>=virtual/jdk-1.5
		app-arch/unzip"

src_compile() {
	# Add missing strong name key
	#cp "${FILESDIR}"/key.snk "${S}"/mykey.snk

	# Remove unneccesary executables and
	# Windows-only libraries (bug #186837)
	rm bin/{IKVM*dll,*.exe,JVM.DLL,ikvm-native.dll}

	# We use javac instead of ecj because of
	# memory related problems (see bug #183526)
	sed -i \
		-e 's#ecj#javac#' \
		-e 's#-1.5#-J-mx384M -source 1.5#' \
		classpath/classpath.build \
	|| die "sed failed"

	mkdir -p "${T}"/home/test

	XDG_CONFIG_HOME="${T}/home/test" nant -t:mono-2.0 signed || die "ikvm build failed"
}

src_install() {
	insinto /usr/$(get_libdir)/${PN}
	doins bin/*

	for exe in ikvm ikvmc ikvmstub;
	do
		make_wrapper ${exe} "mono /usr/$(get_libdir)/${PN}/${exe}.exe"
	done

	dodir /usr/$(get_libdir)/pkgconfig
	sed -e "s:@VERSION@:${PV}:" \
		-e "s:@LIBDIR@:$(get_libdir):" \
		"${FILESDIR}"/${P}.pc.in > "${D}"/usr/$(get_libdir)/pkgconfig/${PN}.pc \
	|| die "sed failed"

	for dll in IKVM.AWT.WinForms IKVM.OpenJDK.ClassLibrary IKVM.Runtime
	do
		gacutil -i bin/${dll}.dll -root "${D}"/usr/$(get_libdir) \
			-gacdir /usr/$(get_libdir) -package ${dll} > /dev/null
	done
}
