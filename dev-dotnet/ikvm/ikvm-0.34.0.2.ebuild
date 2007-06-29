# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ikvm/ikvm-0.34.0.2.ebuild,v 1.2 2007/06/29 02:48:17 jurek Exp $

inherit eutils mono multilib

CLASSPATH_P="classpath-0.95"

ECJ_V=3.2.2
ECJ_DATESTAMP=200702121330

DESCRIPTION="Java VM for .NET"
HOMEPAGE="http://www.ikvm.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip
		mirror://gnu/classpath/${CLASSPATH_P}.tar.gz"
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
	# Remove unneccesary binaries
	rm bin/*.exe

	# We use javac instead of ecj because of
	# memory related problems (see bug #183526)
	sed -i \
		-e 's#ecj#javac#' \
		-e 's#-1.5#-J-mx160M -source 1.5#' \
		classpath/classpath.build \
	|| die "sed failed"

	nant -t:mono-1.0 || die "ikvm build failed"
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
		${FILESDIR}/${PN}.pc.in > ${D}/usr/$(get_libdir)/pkgconfig/${PN}.pc \
	|| die "sed failed"
}
