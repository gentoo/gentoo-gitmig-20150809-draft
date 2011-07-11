# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgamin/libgamin-0.1.10-r2.ebuild,v 1.13 2011/07/11 04:16:29 ssuominen Exp $

EAPI=2

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit autotools eutils flag-o-matic libtool python

MY_PN=${PN//lib/}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Library providing the FAM File Alteration Monitor API"
HOMEPAGE="http://www.gnome.org/~veillard/gamin/"
SRC_URI="http://www.gnome.org/~veillard/${MY_PN}/sources/${MY_P}.tar.gz
	mirror://gentoo/${MY_PN}-0.1.9-freebsd.patch.bz2
	http://pkgconfig.freedesktop.org/releases/pkg-config-0.26.tar.gz" # pkg.m4 for eautoreconf

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="debug kernel_linux python static-libs"

RESTRICT="test" # need gam-server

RDEPEND="!app-admin/fam
	!<app-admin/gamin-0.1.10"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if use python; then
		python_pkg_setup
	fi
}

src_prepare() {
	mv -vf "${WORKDIR}"/pkg-config-*/pkg.m4 "${WORKDIR}"/ || die

	# Fix QA warnings, bug #257281, upstream #466791
	epatch "${FILESDIR}"/${P}-compilewarnings.patch

	# Fix compile warnings; bug #188923
	epatch "${DISTDIR}"/${MY_PN}-0.1.9-freebsd.patch.bz2

	# Fix collision problem due to intermediate library, upstream bug #530635
	epatch "${FILESDIR}"/${P}-noinst-lib.patch

	# Build only shared version of Python module.
	epatch "${FILESDIR}"/${P}-disable_python_static_library.patch

	# Python bindings are built/installed manually.
	sed -e "/SUBDIRS += python/d" -i Makefile.am

	# autoconf is required as the user-cflags patch modifies configure.in
	# however, elibtoolize is also required, so when the above patch is
	# removed, replace the following call with a call to elibtoolize
	AT_M4DIR="${WORKDIR}" eautoreconf

	# disable pyc compiling
	rm -f py-compile
	ln -s $(type -P true) py-compile
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		--disable-debug \
		--disable-server \
		$(use_enable kernel_linux inotify) \
		$(use_enable debug debug-api) \
		$(use_with python)
}

src_compile() {
	default

	if use python; then
		python_copy_sources python

		building() {
			emake \
				PYTHON_INCLUDES="$(python_get_includedir)" \
				PYTHON_SITE_PACKAGES="$(python_get_sitedir)" \
				PYTHON_VERSION="$(python_get_version)"
		}
		python_execute_function -s --source-dir python building
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use python; then
		installation() {
			emake \
				DESTDIR="${D}" \
				PYTHON_SITE_PACKAGES="$(python_get_sitedir)" \
				PYTHON_VERSION="$(python_get_version)" \
				install
		}
		python_execute_function -s --source-dir python installation

		python_clean_installation_image
	fi

	dodoc AUTHORS ChangeLog README TODO NEWS doc/*txt || die
	dohtml doc/* || die

	find "${D}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	if use python; then
		python_mod_optimize gamin.py
	fi
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup gamin.py
	fi
}
