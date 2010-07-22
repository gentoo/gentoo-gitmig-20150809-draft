# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-docs/python-docs-2.6.5.ebuild,v 1.6 2010/07/22 16:36:26 maekke Exp $

EAPI="3"

DESCRIPTION="HTML documentation for Python"
HOMEPAGE="http://www.python.org/doc/"
SRC_URI="http://www.python.org/ftp/python/doc/${PV}/python-${PV}-docs-html.tar.bz2"

LICENSE="PSF-2.2"
SLOT="2.6"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~m68k ~mips ppc ~ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=">=app-admin/eselect-python-20091230"
RDEPEND="${DEPEND}"

S="${WORKDIR}/python-${PV}-docs-html"

src_install() {
	docinto html
	cp -R [a-z]* _static "${ED}usr/share/doc/${PF}/html"

	echo "PYTHONDOCS_${SLOT//./_}=\"${EPREFIX}/usr/share/doc/${PF}/html/library\"" > "60python-docs-${SLOT}"
	doenvd "60python-docs-${SLOT}"
}

eselect_python_update() {
	local eselect_python_options
	[[ "$(eselect python show)" == "python2."* ]] && eselect_python_options="--python2"

	# Create python2 symlink.
	eselect python update --python2 > /dev/null

	eselect python update ${eselect_python_options}
}

pkg_postinst() {
	eselect_python_update
}

pkg_postrm() {
	eselect_python_update

	if ! has_version "<dev-python/python-docs-${SLOT}_alpha" && ! has_version ">=dev-python/python-docs-${SLOT%.*}.$((${SLOT#*.}+1))_alpha"; then
		rm -f "${EROOT}etc/env.d/65python-docs"
	fi
}
