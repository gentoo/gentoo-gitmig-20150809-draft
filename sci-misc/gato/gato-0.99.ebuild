# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/gato/gato-0.99.ebuild,v 1.1 2007/08/24 13:29:01 markusle Exp $

inherit eutils

MY_P="Gato"
MY_PV="0.99"

DESCRIPTION="Graph Animation Toolbox"
LICENSE="LGPL-2"
HOMEPAGE="http://gato.sourceforge.net/"
SRC_URI="http://gato.sourceforge.net/Download/${MY_P}-${MY_PV}.tar.gz
		doc? ( http://gato.sourceforge.net/Download/${MY_P}-Doc-${MY_PV}.tar.gz )"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="doc"

DEPEND=""
RDEPEND="dev-lang/python
		dev-lang/tk"

S="${WORKDIR}"/Gato
GATO_DOC="${WORKDIR}"/Doc

src_unpack() {
	unpack ${A}

	# convert to python2.4
	epatch "${FILESDIR}"/${P}-python.patch

	cd "${S}"
	# change TKinter call to avoid crashing of X
	sed -e "s:self.overrideredirect(1):self.overrideredirect(0):" \
		-i GatoDialogs.py || die "failed to patch GatoDialogs.py"
}

src_install() {

	# install python code
	insinto /usr/lib/${PN}
	doins *.py || die "Failed to install python files"
	fperms 755 /usr/lib/${PN}/Gato.py /usr/lib/${PN}/Gred.py

	# create symlinks
	dodir /usr/bin
	dosym /usr/lib/${PN}/Gato.py /usr/bin/gato
	dosym /usr/lib/${PN}/Gred.py /usr/bin/gred

	# install data files
	insinto /usr/share/${PN}
	doins BFS.* DFS.* sample.cat || die "failed to data files"

	# install docs
	if use doc; then
		dohtml -r ${GATO_DOC}/*
	fi
}
