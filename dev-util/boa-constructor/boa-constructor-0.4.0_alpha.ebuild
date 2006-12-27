# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/boa-constructor/boa-constructor-0.4.0_alpha.ebuild,v 1.4 2006/12/27 17:52:02 gustavoz Exp $

inherit eutils python

MY_P=${P/_alpha/}
DESCRIPTION="Python GUI RAD development tool."
HOMEPAGE="http://boa-constructor.sourceforge.net/"
SRC_URI="mirror://sourceforge/boa-constructor/${MY_P}.src.zip"
S=${WORKDIR}/${MY_P}
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="=dev-python/wxpython-2.6*
	dev-libs/expat"

DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	cd ${S} || die "Failed to cd ${S}"
	epatch ${FILESDIR}/${P}-wxversion.patch
}

src_compile() {
	python -c "import compileall; compileall.compile_dir('.', force=1)"
}

src_install () {
	python_version
	local boadir="/usr/lib/python${PYVER}/site-packages/boa"

	local dir
	for dir in `find . -type d`
	do
		insinto "${boadir}/${dir}"
		cd "${dir}"
		local file
		for file in *
		do
			[ -f "${file}" ] && doins "${file}"
		done
		cd "${S}"
	done

	insinto "${boadir}"
	insinto "${boadir}/Plug-ins"
	doins Plug-ins/*

	dobin "${FILESDIR}/boa-constructor"

	dodoc Bugs.txt Changes.txt Credits.txt README.txt
}
