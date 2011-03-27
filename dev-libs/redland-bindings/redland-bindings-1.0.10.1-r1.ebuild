# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/redland-bindings/redland-bindings-1.0.10.1-r1.ebuild,v 1.4 2011/03/27 15:46:36 arfrever Exp $

EAPI=3
PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit multilib python

DESCRIPTION="Language bindings for Redland"
HOMEPAGE="http://librdf.org/bindings/"
SRC_URI="http://download.librdf.org/source/${P}.tar.gz"

LICENSE="Apache-2.0 GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux ~ppc-macos"
IUSE="perl python php ruby"

RDEPEND=">=dev-libs/redland-1.0.10-r1
	perl? ( dev-lang/perl )
	php? ( dev-lang/php )
	ruby? ( dev-lang/ruby dev-ruby/log4r )"
DEPEND="${RDEPEND}
	dev-lang/swig
	sys-apps/sed
	perl? ( sys-apps/findutils )"

pkg_setup() {
	use python && python_pkg_setup
}

src_prepare() {
	sed -i \
		-e "s:lib/python:$(get_libdir)/python:" \
		configure || die
}

src_configure() {
	# --with-python-ldflags line can be dropped from next release
	# as it's been fixed in trunk
	econf \
		--disable-dependency-tracking \
		$(use_with perl) \
		$(use_with python) \
		--with-python-ldflags="-shared -lrdf" \
		$(use_with php) \
		$(use_with ruby) \
		--with-redland=system

	# Python bindings are built/tested/installed manually.
	sed -e "/^SUBDIRS =/s/ python//" -i Makefile
}

src_compile() {
	default

	if use python; then
		python_copy_sources python

		building() {
			emake \
				PYTHON_INCLUDES="-I$(python_get_includedir)" \
				pythondir="$(python_get_sitedir)"
		}
		python_execute_function -s --source-dir python building
	fi
}

src_test() {
	default

	if use python; then
		testing() {
			emake \
				PYTHON="$(PYTHON)" \
				check
		}
		python_execute_function -s --source-dir python testing
	fi
}

src_install() {
	emake DESTDIR="${D}" INSTALLDIRS=vendor install || die

	if use perl; then
		find "${D}" -type f -name perllocal.pod -delete
		find "${D}" -depth -mindepth 1 -type d -empty -delete
	fi

	if use python; then
		installation() {
			emake \
				DESTDIR="${D}" \
				pythondir="$(python_get_sitedir)" \
				install
		}
		python_execute_function -s --source-dir python installation
	fi

	dodoc AUTHORS ChangeLog NEWS README TODO
	dohtml {NEWS,README,RELEASE,TODO}.html
}

pkg_postinst() {
	use python && python_mod_optimize RDF.py
}

pkg_postrm() {
	use python && python_mod_cleanup RDF.py
}
