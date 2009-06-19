# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cola/cola-1.3.8.ebuild,v 1.1 2009/06/19 07:48:50 dev-zero Exp $

EAPI="2"

inherit distutils eutils

DESCRIPTION="A sweet, carbonated git gui known for its sugary flavour and caffeine-inspired features."
HOMEPAGE="http://cola.tuxfamily.org/"
SRC_URI="http://cola.tuxfamily.org/releases/${P}-src.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

RDEPEND="dev-python/PyQt4
	|| ( >=dev-lang/python-2.6 ( =dev-lang/python-2.5* dev-python/simplejson ) )
	dev-python/pyinotify
	dev-python/jsonpickle
	dev-util/git"
DEPEND="${RDEPEND}
	doc? ( app-text/asciidoc )
	test? ( dev-python/nose )"

src_prepare() {
	# don't install docs into wrong location
	sed -i \
		-e '/doc/d' \
		setup.py || die "sed failed"
	# don't prefix install path with homedir
	rm setup.cfg

	epatch "${FILESDIR}/${PV}-disable-tests.patch"
}

src_compile() {
	distutils_src_compile

	if use doc ; then
		cd share/doc/git-cola/
		emake || die "building docs failed"
	fi
}

src_install() {
	distutils_src_install

	# remove bundled libraries
	rm -rf "${D}"/usr/share/git-cola/lib/{jsonpickle,simplejson}

	cd share/doc/git-cola/
	dodoc *.txt

	if use doc ; then
		dohtml *.html
		doman *.1
	fi
}

src_test() {
	PYTHONPATH="$(pwd):$(pwd)/build/lib:${PYTHONPATH}" nosetests \
		--verbose --with-doctest --with-id --exclude=jsonpickle --exclude=json \
		|| die "running nosetests failed"
}

pkg_postinst() {
	python_mod_optimize /usr/share/git-cola
}

pkg_postrm() {
	python_mod_cleanup /usr/share/git-cola
}
