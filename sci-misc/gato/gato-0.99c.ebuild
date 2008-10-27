# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/gato/gato-0.99c.ebuild,v 1.4 2008/10/27 12:06:52 bicatali Exp $

EAPI=2
inherit python eutils multilib

MY_PN="Gato"
MY_PV=$(echo ${PV} | tr '[:lower:]' '[:upper:]')

DESCRIPTION="Graph Animation Toolbox"
LICENSE="LGPL-2"
HOMEPAGE="http://gato.sourceforge.net/"
SRC_URI="http://gato.sourceforge.net/Download/${MY_PN}-${MY_PV}.tar.gz
	doc? ( http://gato.sourceforge.net/Download/${MY_PN}-Doc-${MY_PV}.tar.gz )"

SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc"
DEPEND="dev-lang/python[tk]"

S="${WORKDIR}"/${MY_PN}

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
	python_version
	local instdir=/usr/$(get_libdir)/python${PYVER}/${PN}
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
