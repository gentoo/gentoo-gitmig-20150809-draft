# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dbus-python/dbus-python-1.0.0.ebuild,v 1.1 2012/01/25 21:07:58 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.6 3:3.2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython *-pypy-*"
PYTHON_TESTS_RESTRICTED_ABIS="2.4 2.5 3.0 3.1"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit eutils python

DESCRIPTION="Python bindings for the D-Bus messagebus"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/DBusBindings http://dbus.freedesktop.org/doc/dbus-python/"
SRC_URI="http://dbus.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="doc examples test"

RDEPEND=">=dev-libs/dbus-glib-0.98
	>=sys-apps/dbus-1.4.16"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( =dev-python/epydoc-3* )
	test? (
		dev-python/pygobject:2
		dev-python/pygobject:3
		)"

src_prepare() {
	# Disable compiling of .pyc files.
	>py-compile

	# Simple sed to avoid an eautoreconf
	# bug #363679, https://bugs.freedesktop.org/show_bug.cgi?id=43735
	sed -i -e 's/\(RST2HTMLFLAGS=\)$/\1--input-encoding=UTF-8/' configure || die

	python_src_prepare
}

src_configure() {
	configuration() {
		econf \
			--docdir="${EPREFIX}"/usr/share/doc/${PF} \
			--disable-html-docs \
			$(use_enable doc api-docs)
	}
	python_execute_function -s configuration
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	python_src_test
}

src_install() {
	python_src_install

	if use doc; then
		install_documentation() {
			nonfatal dohtml -r api/*
		}
		python_execute_function -f -q -s install_documentation
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	python_clean_installation_image
}

pkg_postinst() {
	python_mod_optimize dbus
}

pkg_postrm() {
	python_mod_cleanup dbus
}
