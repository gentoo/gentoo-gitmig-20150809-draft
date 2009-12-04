# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-docs/python-docs-2.6.4.ebuild,v 1.3 2009/12/04 16:06:52 jer Exp $

DESCRIPTION="HTML documentation for Python"
HOMEPAGE="http://www.python.org/doc/"
SRC_URI="http://www.python.org/ftp/python/doc/${PV}/python-${PV}-docs-html.tar.bz2"

LICENSE="PSF-2.2"
SLOT="2.6"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=">=app-admin/eselect-python-20090606"
RDEPEND="${DEPEND}"

S="${WORKDIR}/python-${PV}-docs-html"

src_install() {
	[[ -z "${ED}" ]] && local ED="${D}"
	docinto html
	cp -R [a-z]* _static "${ED}usr/share/doc/${PF}/html"

	echo "PYTHONDOCS_${SLOT//./_}=\"${EPREFIX}/usr/share/doc/${PF}/html/library\"" > "60python-docs-${SLOT}"
	doenvd "60python-docs-${SLOT}"
}

eselect_python_update() {
	local ignored_python_slots_options
	[[ "$(eselect python show)" == "python2."* ]] && ignored_python_slots_options="--ignore 3.0 --ignore 3.1 --ignore 3.2"

	# Create python2 symlink.
	eselect python update --ignore 3.0 --ignore 3.1 --ignore 3.2 > /dev/null

	eselect python update ${ignored_python_slots_options}
}

pkg_postinst() {
	eselect_python_update
}

pkg_postrm() {
	[[ -z "${EROOT}" ]] && local EROOT="${ROOT}"
	eselect_python_update

	if ! has_version "<dev-python/python-docs-${SLOT}_alpha" && ! has_version ">=dev-python/python-docs-${SLOT%.*}.$((${SLOT#*.}+1))_alpha"; then
		rm -f "${EROOT}etc/env.d/65python-docs"
	fi

	rm -f "${EROOT}etc/env.d/50python-docs"
}
