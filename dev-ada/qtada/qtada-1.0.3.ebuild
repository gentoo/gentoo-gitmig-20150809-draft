# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/qtada/qtada-1.0.3.ebuild,v 1.1 2008/05/20 09:32:07 george Exp $

# We only need gnat.eclass for a few vars and helper functions.
# We will not use src_* functions though.
inherit eutils multilib gnat

IUSE=""

DESCRIPTION="Ada bindings for Qt library"
HOMEPAGE="http://www.qtada.com/"
SRC_URI="mirror://sourceforge/qtada/${PN}-gpl-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

# qtada is quite picky atm. For example this version will only compile with
# the specified gnat, not even gnat-gcc-4.3.0 for example.
RDEPEND="=dev-lang/gnat-gpl-4.1*
	dev-ada/asis-gpl
	>=x11-libs/qt-4.2.0"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-gpl-${PV}"

#LIBDIR=/usr/lib/ada/i686-pc-linux-gnu-gnat-gpl-4.1/qtada

pkg_setup() {
	local ActiveGnat=$(get_active_profile)
	if [[ ! ${ActiveGnat} =~ "gnat-gpl-4.1" ]]; then
		ewarn "This version of qtada can only be compiled with gnat-gpl-4.1"
		die   "Please switch to  gnat-gpl-4.1 and try again"
	fi
	if ! built_with_use ">=x11-libs/qt-4.0" accessibility ; then
		die "Rebuild qt-4 with USE=accessibility"
	fi
}


# As this version of qtada only compiles with gnat-gpl-4.1 and we already
# verified that it is active, we do not switch profiles or do any majic here.
# We simplt run build once, just need to set some path appropriately.
src_compile() {
	econf --datadir=${AdalibDataDir}/${PN} \
		--includedir=${AdalibSpecsDir}/${PN} \
		--libdir=${AdalibLibTop}/$(get_active_profile)/${PN} || die "econf failed"
	emake || die "make failed"
}

src_install() {
	# set common part of the path
	local InstTop=${AdalibLibTop}/$(get_active_profile)

	# run upstream setup
	einstall \
		libdir=${D}/${InstTop}/${PN} \
		bindir=${D}/${InstTop}/bin \
		includedir=${D}/${AdalibSpecsDir} || die "install failed"

	# move .ali file together with .so's
	mv "${D}"/${InstTop}/${PN}/${PN}/*.ali "${D}"/${InstTop}/${PN}/
	rmdir "${D}"/${InstTop}/${PN}/${PN}/

	# arrange and fix gpr files
	mv "${D}"/${InstTop}/${PN}/gnat "${D}"/${InstTop}/gpr
	sed -i -e "s:/usr/include:${AdalibSpecsDir}:" \
		-e "s:/usr/lib:${InstTop}/${PN}:" \
		-e "s:${PN}/${PN}:${PN}" "${D}"/${InstTop}/gpr/*.gpr

	# Create an environment file
	local SpecFile="${D}/usr/share/gnat/eselect/${PN}/$(get_active_profile)"
	dodir /usr/share/gnat/eselect/${PN}/
	echo "PATH=${InstTop}/bin" > "${SpecFile}"
	echo "ADA_INCLUDE_PATH=${AdalibSpecsDir}/${PN}/core" >> "${SpecFile}"
	echo "ADA_OBJECTS_PATH=${InstTop}/${PN}" >> "${SpecFile}"
	echo "ADA_PROJECT_PATH=${InstTop}/gpr" >> "${SpecFile}"

	# install docs
	dodoc AUTHORS NEWS README
	mv "${D}"/usr/examples/${PN} "${D}"/usr/share/doc/${PF}/examples
	rmdir "${D}"/usr/examples/
}
