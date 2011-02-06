# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope/zope-2.13.3.ebuild,v 1.1 2011/02/06 18:48:53 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.* *-jython"

inherit distutils multilib versionator

MY_PN="Zope2"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Zope 2 application server / web framework"
HOMEPAGE="http://www.zope.org http://zope2.zope.org http://pypi.python.org/pypi/Zope2 https://launchpad.net/zope2"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.zip"

LICENSE="ZPL"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="doc"
RESTRICT="test"

RDEPEND="dev-python/docutils
	dev-python/restrictedpython
	dev-python/setuptools
	net-zope/accesscontrol
	net-zope/acquisition
	net-zope/datetime
	net-zope/documenttemplate
	net-zope/extensionclass
	net-zope/initgroups
	net-zope/missing
	net-zope/multimapping
	|| ( net-zope/namespaces-zope[Products,Shared,Shared-DC] net-zope/namespaces )
	net-zope/persistence
	net-zope/record
	net-zope/tempstorage
	net-zope/transaction
	net-zope/zconfig
	net-zope/zdaemon
	net-zope/zexceptions
	net-zope/zlog
	>=net-zope/zodb-3.9
	net-zope/zope-app-form
	net-zope/zope-browser
	net-zope/zope-browsermenu
	net-zope/zope-browserpage
	net-zope/zope-browserresource
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
	net-zope/zope-pagetemplate
	net-zope/zope-processlifetime
	net-zope/zope-proxy
	net-zope/zope-ptresource
	net-zope/zope-publisher
	net-zope/zope-schema
	net-zope/zope-security
	net-zope/zope-sendmail
	net-zope/zope-sequencesort
	net-zope/zope-site
	net-zope/zope-size
	net-zope/zope-structuredtext
	>=net-zope/zope-tales-3.5.0
	net-zope/zope-testbrowser
	net-zope/zope-testing
	net-zope/zope-traversing
	net-zope/zope-viewlet
	net-zope/zopeundo"
DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( dev-python/sphinx )"
PDEPEND=">=net-zope/btreefolder2-2.13.0
	net-zope/externalmethod
	net-zope/mailhost
	net-zope/mimetools
	net-zope/ofsp
	net-zope/pythonscripts
	net-zope/standardcachemanagers
	net-zope/zcatalog
	net-zope/zctextindex"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_pkg_setup
	ZOPE_INSTALLATION_DIR="usr/$(get_libdir)/${PN}-${SLOT}"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		"$(PYTHON -f)" setup.py build_sphinx || die "Generation of documentation failed"
	fi
}

distutils_src_install_post_hook() {
	mv "${T}/images/${PYTHON_ABI}/${ZOPE_INSTALLATION_DIR}/lib/python"{,-${PYTHON_ABI}}
}

src_install() {
	distutils_src_install --home="${ZOPE_INSTALLATION_DIR}"

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
	insinto "/${ZOPE_INSTALLATION_DIR}/skel"
	doins "${FILESDIR}/zope.initd" || die "doins failed"
}

pkg_postinst() {
	python_mod_optimize --allow-evaluated-non-sitedir-paths "/${ZOPE_INSTALLATION_DIR}/lib/python-\${PYTHON_ABI}"
}

pkg_postrm() {
	python_mod_cleanup --allow-evaluated-non-sitedir-paths "/${ZOPE_INSTALLATION_DIR}/lib/python-\${PYTHON_ABI}"
}
