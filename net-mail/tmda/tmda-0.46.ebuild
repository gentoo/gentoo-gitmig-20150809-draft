# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Arcady Genkin <agenkin@thpoon.com>
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.14 2002/02/01 19:50:13 gbevin Exp

S="${WORKDIR}/${P}"

DESCRIPTION="Python-based SPAM reduction system"
SRC_URI="http://software.libertine.org/tmda/releases/${P}.tgz"
HOMEPAGE="http://software.libertine.org/tmda/index.html"

DEPEND=">=dev-lang/python-2.0 virtual/mta"

src_compile() {
        ./compileall || die
}

src_install () {
        # Figure out python version
        # below hack should be replaced w/ pkg-config, when we get it working
        local pv=`python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:'`

        # Executables
        dobin bin/tmda-*

        # The Python TMDA module
        insinto "/usr/lib/python${pv}/site-packages/TMDA"
        doins TMDA/*

        # The templates
        insinto /etc/tmda
        doins templates/*
        
        # Documentation
        dodoc COPYRIGHT ChangeLog README THANKS UPGRADE CRYPTO
        dohtml -r htdocs/*.html

        # Contributed binaries and stuff
        cd contrib
        dodoc README.RELAY qmail-smtpd_auth.patch tmda.spec sample.tmdarc
        exeinto /usr/lib/tmda/bin
        doexe list2cdb list2dbm printcdb printdbm
        insinto /usr/lib/tmda
        doins setup.pyc
        exeinto /usr/lib/tmda
        doexe setup.py
}
