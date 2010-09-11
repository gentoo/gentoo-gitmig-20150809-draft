# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope/zope-2.12.10.ebuild,v 1.1 2010/09/11 21:58:55 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.*"

inherit distutils eutils multilib versionator

MY_PN="Zope2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope 2 application server / web framework"
HOMEPAGE="http://www.zope.org http://zope2.zope.org http://pypi.python.org/pypi/Zope2"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

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
	net-zope/namespaces
	net-zope/persistence
	net-zope/record
	net-zope/tempstorage
	net-zope/threadlock
	net-zope/transaction
	net-zope/zconfig
	net-zope/zdaemon
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
	net-zope/zopeundo"
DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( dev-python/sphinx )"
PDEPEND="net-zope/zsqlmethods"

S="${WORKDIR}/${MY_P}"

ZOPE_INSTALLATION_DIR="/usr/$(get_libdir)/${PN}-${SLOT}"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		"$(PYTHON -f)" setup.py build_sphinx || die "Generation of documentation failed"
	fi
}

distutils_src_install_post_hook() {
	mv "${D}${ZOPE_INSTALLATION_DIR}/lib/python" "${D}${ZOPE_INSTALLATION_DIR}/lib/python-${PYTHON_ABI}"
}

src_install() {
	distutils_src_install --home="${ZOPE_INSTALLATION_DIR}"

	# Don't install C sources.
	find "${D}${ZOPE_INSTALLATION_DIR}" -name "*.c" | xargs rm -f

	local file
	for file in "${D}${ZOPE_INSTALLATION_DIR}/bin/"*; do
		scripts_preparation() {
			cp "${file}" "${file}-${PYTHON_ABI}" || return 1
			python_convert_shebangs -q $(python_get_version) "${file}-${PYTHON_ABI}"
			sed \
				-e "/import sys/i import os\nos.environ['PYTHONPATH'] = (os.environ.get('PYTHONPATH') + ':' if os.environ.get('PYTHONPATH') is not None else '') + os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'lib', 'python-${PYTHON_ABI}'))" \
				-e "/import sys/a sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'lib', 'python-${PYTHON_ABI}')))" \
				-i "${file}-${PYTHON_ABI}"
		}
		python_execute_function -q scripts_preparation

		python_generate_wrapper_scripts -f "${file}"
	done

	modules_installation() {
		local module
		for module in Products Shared Shared/DC; do
			echo "__import__('pkg_resources').declare_namespace(__name__)" > "${D}${ZOPE_INSTALLATION_DIR}/lib/python-${PYTHON_ABI}/${module}/__init__.py" || return 1
		done
	}
	python_execute_function -q modules_installation

	skel_preparation() {
		sed -e "/^ZOPE_RUN=/s/runzope/&-${PYTHON_ABI}/" -i "${D}${ZOPE_INSTALLATION_DIR}/lib/python-${PYTHON_ABI}/Zope2/utilities/skel/bin/runzope.in" || return 1
		sed -e "/^ZDCTL=/s/zopectl/&-${PYTHON_ABI}/" -i "${D}${ZOPE_INSTALLATION_DIR}/lib/python-${PYTHON_ABI}/Zope2/utilities/skel/bin/zopectl.in" || return 1
	}
	python_execute_function -q skel_preparation

	if use doc; then
		pushd build/sphinx/html > /dev/null
		dodoc _sources/* || die "Installation of documentation failed"
		docinto html
		dohtml -r [A-Za-z]* _static || die "Installation of documentation failed"
		popd > /dev/null
	fi

	# Copy the init script skeleton to skel directory of our installation.
	insinto "${ZOPE_INSTALLATION_DIR}/skel"
	doins "${FILESDIR}/zope.initd" || die "doins failed"
}

pkg_postinst() {
#	python_mod_optimize --allow-evaluated-non-sitedir-paths "${ZOPE_INSTALLATION_DIR}/lib/python-\${PYTHON_ABI}"
	byte-compilation() {
		"$(PYTHON)" "$(python_get_libdir)/compileall.py" -q ${ZOPE_INSTALLATION_DIR}/lib/python-${PYTHON_ABI}
		"$(PYTHON)" -O "$(python_get_libdir)/compileall.py" -q ${ZOPE_INSTALLATION_DIR}/lib/python-${PYTHON_ABI}
	}
	python_execute_function -q byte-compilation
}

pkg_postrm() {
#	python_mod_cleanup --allow-evaluated-non-sitedir-paths "${ZOPE_INSTALLATION_DIR}/lib/python-\${PYTHON_ABI}"
	SUPPORT_PYTHON_ABIS="" python_mod_cleanup ${ZOPE_INSTALLATION_DIR}/lib
}
