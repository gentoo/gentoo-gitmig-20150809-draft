# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/nant/nant-0.86_beta1.ebuild,v 1.1 2009/05/03 20:29:38 loki_val Exp $

EAPI=2

inherit mono multilib eutils

DESCRIPTION=".NET build tool"
HOMEPAGE="http://nant.sourceforge.net/"
SRC_URI="mirror://sourceforge/nant/${P/_/-}-src.tar.gz
	build? ( mirror://sourceforge/nant/${P/_/-}-bin.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+bootstrap"

RDEPEND="
	bootstrap? (
		>=dev-lang/mono-2.0
	)
	!bootstrap? (
		>=dev-dotnet/ndoc-1.3.1-r3
		>=dev-lang/mono-2.4
	)
	"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

# This build is not parallel build friendly
MAKEOPTS="${MAKEOPTS} -j1"

S="${WORKDIR}/${P/_/-}"

pkg_setup() {
	if use bootstrap && has_version '>=dev-dotnet/ndoc-1.3.1-r3' && has_version '>=dev-lang/mono-2.4'
	then
		elog "USE=bootstrap is set. Bootstrapping is required on first install of"
		elog "${CATEGORY}/${PN} and is set to on by default to not break up"
		elog "the dependency graph, since USE=-bootstrap requires:"
		elog ">=dev-lang/mono-2.4"
		elog ">=dev-dotnet/ndoc-1.3.1-r3"
		elog "Which would cause a circular dependency between ${CATEGORY}/${PN} and"
		elog "dev-dotnet/ndoc."
		elog "You have both installed, so you can set USE=-bootstrap and re-emerge:"
		elog "echo '${CATEGORY}/${PN} -bootstrap' >> /etc/portage/package.use"
		elog "emerge -1 =${CATEGORY}/${PF}"
	fi
}
src_prepare() {
	if ! use bootstrap
	then
		edos2unix NAnt.build src/NAnt.NUnit/NAnt.NUnit.build
		sed -e "s:@LIB@:$(get_libdir):" "${FILESDIR}/${P}-build.patch" \
			> "${WORKDIR}/${P}-build.patch"
		epatch "${WORKDIR}/${P}-build.patch"
		epatch "${FILESDIR}/${P}-dropnunit1.patch"
		epatch "${FILESDIR}/${P}-nunit-2.4.8.patch"
		epatch "${FILESDIR}/${P}-refmono-nunit.patch"

		rm -rf lib/common/neutral/NUnitCore.dll

		for file in lib/mono/*/nunit*.dll
		do
			echo $file
			mono_file=${file#lib/}
			rm -f $file
			ln -s "/usr/$(get_libdir)/${mono_file}" "$file" || die
		done

		for file in lib/mono/*/NDoc*.dll
		do
			echo $file
			mono_file=${file#lib/mono/*/}
			rm -f $file
			ln -s "/usr/$(get_libdir)/mono/ndoc/${mono_file}" "$file" || die
		done
	fi
}

src_compile() {
	emake || die
}

src_install() {
	make prefix="${D}/usr" install || die "install failed"

	# Fix ${D} showing up in the nant wrapper script, as well as silencing
	# warnings related to the log4net library
	sed -i \
		-e "s:${D}::" \
		-e "2iexport MONO_SILENT_WARNING=1" \
		"${D}"/usr/bin/nant || die "Sed nant failed"

	dodoc README.txt
	if ! use bootstrap
	then
		rm -rf "${D}"/usr/$(get_libdir)/NAnt/bin/lib/{mono,net}
	fi
}
