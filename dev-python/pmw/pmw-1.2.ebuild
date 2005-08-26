# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pmw/pmw-1.2.ebuild,v 1.12 2005/08/26 03:34:01 agriffis Exp $

inherit distutils python

DESCRIPTION="A toolkit for building high-level compound widgets in Python using the Tkinter module."
HOMEPAGE="http://pmw.sourceforge.net/"
SRC_URI="mirror://sourceforge/pmw/Pmw.${PV}.tar.gz"

SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
LICENSE="MIT"
IUSE=""

DEPEND=">=dev-lang/python-2.1"
S="${WORKDIR}/Pmw"

pkg_setup() {
	# check for Tkinter support in python
	if ! python_mod_exists Tkinter; then
		eerror "This package requires Tkinter support in Python. You'll need"
		eerror "to recompile Python with:"
		eerror "USE=\"tcltk\" emerge python"
		die "Tkinter support missing"
	fi
}

src_compile() {
	return
}

src_install() {
	python_version

	local pmwdir="/usr/lib/python${PYVER}/site-packages/Pmw"

	local dir
	for dir in `find . -type d` ; do
		# Skip the doc directory
		[ `basename "${dir}"` = "doc" ] && continue

		insinto "${pmwdir}/${dir}"
		cd "${dir}"
		# Install all regular files in this dir
		local file
		for file in * ; do
			[ -f "${file}" ] && doins "${file}"
		done
		cd "${S}"
	done

	dodoc README
	local docdir=`find . -type d -name doc`
	dohtml -a html,gif,py "${docdir}"/*
}
