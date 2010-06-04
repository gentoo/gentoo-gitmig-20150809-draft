# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/gato/gato-0.99c.ebuild,v 1.5 2010/06/04 16:20:34 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"

inherit eutils python

MY_PN="Gato"
MY_PV=$(echo ${PV} | tr '[:lower:]' '[:upper:]')

DESCRIPTION="Graph Animation Toolbox"
HOMEPAGE="http://gato.sourceforge.net/"
SRC_URI="http://gato.sourceforge.net/Download/${MY_PN}-${MY_PV}.tar.gz
	doc? ( http://gato.sourceforge.net/Download/${MY_PN}-Doc-${MY_PV}.tar.gz )"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_PN}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# convert to python >=2.4
	epatch "${FILESDIR}"/${P}-python.patch
	# change TKinter call to avoid crashing of X
	sed -i \
		-e 's:self.overrideredirect(1):self.overrideredirect(0):' \
		"${S}"/GatoDialogs.py || die "failed to patch GatoDialogs.py"
}

src_install() {
	# install python code
	local instdir=$(python_get_sitedir)/${PN}
	insinto ${instdir}
	doins *.py || die "Failed to install python files"
	fperms 755 ${instdir}/{Gato,Gred}.py

	# create symlinks
	dodir /usr/bin
	dosym ${instdir}/Gato.py /usr/bin/gato
	dosym ${instdir}/Gred.py /usr/bin/gred

	# install data files
	insinto /usr/share/${PN}
	doins BFS.* DFS.* sample.cat || die "failed to data files"

	use doc && dohtml -r "${WORKDIR}"/Doc/*
}

pkg_postinst() {
	python_mod_optimize gato
}

pkg_postrm() {
	python_mod_cleanup gato
}
