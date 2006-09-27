# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pmw/pmw-1.1.ebuild,v 1.10 2006/09/27 17:23:17 marienz Exp $

DESCRIPTION="A toolkit for building high-level compound widgets in Python using the Tkinter module."
HOMEPAGE="http://pmw.sourceforge.net/"
SRC_URI="mirror://sourceforge/pmw/Pmw.${PV}.tar.gz"

SLOT="0"
KEYWORDS="x86 ppc sparc"
LICENSE="MIT"
IUSE=""

DEPEND=">=dev-lang/python-2.1"
S="${WORKDIR}/Pmw"

src_compile() {
	distutils_python_tkinter
	python -c 'import compileall; compileall.compile_dir(".",force=1)'
}

src_install() {
	# Figures out the destination directory, based on Python's version installed.
	local pv=`python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:'`
	local pmwdir="/usr/lib/python${pv}/site-packages/Pmw"

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
