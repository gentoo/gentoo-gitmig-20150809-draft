# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pmw/pmw-0.8.5.ebuild,v 1.14 2003/06/22 12:15:59 liquidx Exp $

DESCRIPTION="A toolkit for building high-level compound widgets in Python using the Tkinter module."
HOMEPAGE="http://pmw.sourceforge.net/"

DEPEND=">=dev-lang/python-2.1"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
LICENSE="MIT"


SRC_URI="mirror://sourceforge/pmw/Pmw.${PV}.tar.gz"
S="${WORKDIR}"/Pmw

src_compile() {
    if ! python -c "import Tkinter" >/dev/null 2>&1
        then
        die "You need to recompile Python with Tkinter support"
    fi
    python -c 'import compileall; compileall.compile_dir(".",force=1)'
}

src_install () {
    # Figures out the destination directory, based on Python's version
    # installed.
    local pv=`python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:'`
    local pmwdir="/usr/lib/python${pv}/site-packages/Pmw"

    local dir
    for dir in `find . -type d`
    do
        # Skip the doc directory
        if [ `basename "${dir}"` = "doc" ]
        then
            continue
        fi
        insinto "${pmwdir}/${dir}"
        cd "${dir}"
        # Install all regular files in this dir
        local file
        for file in *
        do
            [ -f "${file}" ] && doins "${file}"
        done
        cd "${S}"
    done

    dodoc README
    local docdir=`find . -type d -name doc`
    dohtml -a html,gif,py "${docdir}"/*
}
