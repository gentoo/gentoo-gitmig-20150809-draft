# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ndoc/ndoc-1.3.1-r3.ebuild,v 1.2 2009/05/04 06:56:15 mr_bones_ Exp $

EAPI=2

inherit mono

DESCRIPTION=".NET Documentation Tool"
HOMEPAGE="http://ndoc.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${PN}-devel-v${PV}.zip"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE="doc"
RDEPEND=">=dev-lang/mono-1.0"
DEPEND="${RDEPEND}
	>=dev-dotnet/nant-0.85_rc2
	app-arch/unzip
	dev-util/pkgconfig"

S=${WORKDIR}

src_prepare() {
	sed -r -i -e 's: doc="[^"]+\"::' $(find . -name '*.build')
}

src_compile() {
	# Workaround some unused private warnings which the buildfiles are treating as errors
	find "${S}" -name '*.build' -exec sed -e 's@warnaserror="true"@@g' -i {} \;

	nant -t:mono-1.0 || die
}

DLL_FILES="NDoc.Core.dll NDoc.Documenter.JavaDoc.dll NDoc.Documenter.Latex.dll NDoc.Documenter.LinearHtml.dll NDoc.Documenter.Msdn.dll NDoc.Documenter.Msdn2.dll NDoc.Documenter.Xml.dll NDoc.ExtendedUI.dll NDoc.VisualStudio.dll"

src_install() {
	cd "${S}"/bin/mono/1.0

	for dll in *.dll *.exe; do
			egacinstall $dll || die "Failed to install $dll."
	done

	cat > ndoc <<- EOF
		#!/bin/bash
		mono \$MONO_OPTIONS /usr/$(get_libdir)/ndoc/NDocConsole.exe "\$@"
	EOF

	dobin ndoc

	use doc && dohtml -a gif,html,css,js -r "${S}"/doc/sdk/
	generate_pkgconfig "${PN}" "NDoc" || die
}

generate_pkgconfig() {
	ebegin "Generating .pc file"
	local	dll \
		LSTRING='Libs:' \
		pkgconfig_filename="${1:-${PN}}" \
		pkgconfig_pkgname="${2:-${pkgconfig_filename}}" \
		pkgconfig_description="${3:-${DESCRIPTION}}"

	dodir "/usr/$(get_libdir)/pkgconfig"
	cat <<- EOF -> "${D}/usr/$(get_libdir)/pkgconfig/${pkgconfig_filename}.pc"
		prefix=/usr
		exec_prefix=\${prefix}
		libdir=\${prefix}/$(get_libdir)
		Name: ${pkgconfig_pkgname}
		Description: ${pkgconfig_description}
		Version: ${PV}
	EOF
	for dll in "${D}"/usr/$(get_libdir)/mono/${pkgconfig_filename}/*.dll
	do
		LSTRING="${LSTRING} -r:"'${libdir}'"/mono/${pkgconfig_filename}/${dll##*/}"
	done
	printf "${LSTRING}" >> "${D}/usr/$(get_libdir)/pkgconfig/${pkgconfig_filename}.pc"
	PKG_CONFIG_PATH="${D}/usr/$(get_libdir)/pkgconfig/" pkg-config --silence-errors --libs ${pkgconfig_filename} &> /dev/null
	eend $?
}
