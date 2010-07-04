# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope/zope-2.12.6.ebuild,v 1.1 2010/07/04 06:42:28 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"

inherit eutils multilib python versionator

MY_PN="Zope2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope is a web application platform used for building high-performance, dynamic web sites"
HOMEPAGE="http://www.zope.org http://pypi.python.org/pypi/Zope2"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"
IUSE="doc"
RESTRICT="test"

RDEPEND="dev-python/docutils
	dev-python/restrictedpython
	dev-python/setuptools
	net-zope/acquisition
	net-zope/datetime
	net-zope/extensionclass
	net-zope/five-formlib
	net-zope/initgroups
	net-zope/missing
	net-zope/multimapping
	net-zope/persistence
	net-zope/record
	net-zope/tempstorage
	net-zope/threadlock
	net-zope/transaction
	net-zope/zdaemon
	net-zope/zconfig
	net-zope/zlog
	>=net-zope/zodb-3.9
	net-zope/zope-app-form
	net-zope/zope-app-publication
	net-zope/zope-app-publisher
	net-zope/zope-app-schema
	net-zope/zope-component
	net-zope/zope-configuration
	net-zope/zope-container
	net-zope/zope-contentprovider
	net-zope/zope-contenttype
	net-zope/zope-deferredimport
	net-zope/zope-event
	net-zope/zope-exceptions
	net-zope/zope-formlib
	net-zope/zope-i18n
	net-zope/zope-i18nmessageid
	net-zope/zope-interface
	net-zope/zope-lifecycleevent
	net-zope/zope-location
	net-zope/zope-mkzeoinstance
	net-zope/zope-pagetemplate
	net-zope/zope-processlifetime
	net-zope/zope-proxy
	net-zope/zope-publisher
	net-zope/zope-schema
	net-zope/zope-security
	<net-zope/zope-sendmail-3.7.0
	net-zope/zope-sequencesort
	net-zope/zope-site
	net-zope/zope-size
	net-zope/zope-structuredtext
	net-zope/zope-tales
	net-zope/zope-testbrowser
	net-zope/zope-testing
	net-zope/zope-traversing
	net-zope/zope-viewlet
	net-zope/zopeundo
"
DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( dev-python/sphinx )"

S="${WORKDIR}/${MY_P}"

ZUID="zope"
ZGID="zope"

ZSERVDIR="/usr/$(get_libdir)/${PN}-${SLOT}"

# Narrow the scope of ownership/permissions.
# Security plan:
# * ZUID is the superuser for all zope instances.
# * ZGID is for a single instance's administration.

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_compile() {
	"$(PYTHON)" setup.py build || die "Building failed"

	if use doc; then
		einfo "Generation of documentation"
		pushd doc > /dev/null
		emake html || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

src_install() {
	"$(PYTHON)" setup.py install --home="${ZSERVDIR}" --root="${D}" || die "Installation failed"
	dosym "$(PYTHON -a)" "${ZSERVDIR}/bin/python" || die "dosym failed"

	for file in "${D}usr/$(get_libdir)/${PN}-${SLOT}/bin/"*; do
		if [[ -f "${file}" && ! -L "${file}" ]]; then
			sed -e '/import sys/iimport os\nos.environ["PYTHONPATH"] = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "lib", "python"))' -e '/import sys/asys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "lib", "python")))' -i "${file}" || die "Changing of os.environ and sys.path in ${file} failed"
		fi
	done

	touch "${D}usr/$(get_libdir)/${PN}-${SLOT}/lib/python/Products/__init__.py" || die "touch failed"

	if use doc; then
		pushd doc/.build/html > /dev/null
		dodoc _sources/* || die "Installation of documentation failed"
		docinto html
		dohtml -r [A-Za-z]* _static || die "Installation of documentation failed"
		popd > /dev/null
	fi

	# Copy the init script skeleton to skel directory of our installation.
	insinto "${ZSERVDIR}/skel"
	doins "${FILESDIR}/zope.initd" || die "doins failed"
}

pkg_postinst() {
	python_mod_optimize "${ZSERVDIR}/lib/python"

	# Create the zope user and group for backward compatibility.
	enewgroup ${ZGID} 261
	usermod -g ${ZGID} ${ZUID} 2>&1 >/dev/null || \
	enewuser ${ZUID} 261 -1 /var/$(get_libdir)/zope  ${ZGID}

	einfo "Be warned that you need at least one zope instance to run zope."
	einfo "Please emerge zope-config for further instance management."
}

pkg_postrm() {
	python_mod_cleanup "${ZSERVDIR}/lib/python"
}
