# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/metakit/metakit-2.4.9.7.ebuild,v 1.10 2010/07/17 12:58:04 fauli Exp $

EAPI="3"
PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils multilib python toolchain-funcs

DESCRIPTION="Embedded database library"
HOMEPAGE="http://www.equi4.com/metakit/"
SRC_URI="http://www.equi4.com/pub/mk/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~s390 ~sparc x86"
IUSE="python static tcl"

DEPEND="tcl? ( >=dev-lang/tcl-8.3.3-r2 )"
RDEPEND="${DEPEND}"

RESTRICT="test"

pkg_setup() {
	if use python; then
		python_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-LDFLAGS.patch"
}

src_configure() {
	local myconf mycxxflags
	use tcl && myconf+=" --with-tcl=/usr/include,/usr/$(get_libdir)"
	use static && myconf+=" --disable-shared"
	use static || mycxxflags="-fPIC"

	sed -i -e "s:^\(CXXFLAGS = \).*:\1${CXXFLAGS} ${mycxxflags} -I\$(srcdir)/../include:" unix/Makefile.in

	CXXFLAGS="${CXXFLAGS} ${mycxxflags}" unix/configure \
		${myconf} \
		--host=${CHOST} \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "configure failed"
}

src_compile() {
	emake SHLIB_LD="$(tc-getCXX) -shared" || die "emake failed"

	if use python; then
		python_copy_sources

		building() {
			emake \
				SHLIB_LD="$(tc-getCXX) -shared" \
				pyincludedir="$(python_get_includedir)" \
				python
		}
		python_execute_function -s building
	fi
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use python; then
		installation() {
			dodir "$(python_get_sitedir)" || return 1
			emake \
				DESTDIR="${D}" \
				pylibdir="$(python_get_sitedir)" \
				install-python
		}
		python_execute_function -s installation
	fi

	dodoc CHANGES README
	dohtml Metakit.html
	dohtml -a html,gif,png,jpg -r doc/*
}

pkg_postinst() {
	if use python; then
		python_mod_optimize metakit.py
	fi
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup metakit.py
	fi
}
