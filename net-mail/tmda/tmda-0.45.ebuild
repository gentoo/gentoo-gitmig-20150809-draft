# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Arcady Genkin <agenkin@thpoon.com>
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.14 2002/02/01 19:50:13 gbevin Exp

S=${WORKDIR}/${P}

DESCRIPTION="Python-based SPAM reduction system"
SRC_URI="http://software.libertine.org/tmda/releases/tmda-0.45.tgz"
HOMEPAGE="http://software.libertine.org/tmda/index.html"

DEPEND=">=python-2.0 virtual/mta"

src_compile() {
	./compileall || die
}

src_install () {
	# Figure out python version
	local pv
        pv=`python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:'`

	# The Python TMDA module
	insinto /usr/lib/python${pv}/site-packages/TMDA
	doins TMDA/*

	# The binaries
	local tmda_binaries
	tmda_binaries="tmda-address tmda-check-address tmda-clean tmda-filter
			tmda-inject tmda-keygen tmda-rfilter tmda-sendmail"
	exeinto /usr/bin
	for f in ${tmda_binaries}; do
		doexe bin/${f}
	done

	# Contributed binaries
	local tmda_contrib_exe
	tmda_contrib_exe="list2cdb list2dbm printcdb printdbm"
	exeinto /usr/lib/tmda/bin
	for f in ${tmda_contrib_exe}; do
		doexe contrib/${f}
	done
	insinto /usr/lib/tmda
	doins contrib/setup.pyc
	exeinto /usr/lib/tmda
	doexe contrib/setup.py

	# The templates
	insinto /etc/tmda
	doins templates/*
	
	# HTML and other documents
        dohtml -r htdocs/*
	local tmda_contrib_doc
        tmda_contrib_doc="README.RELAY qmail-smtpd_auth.patch tmda.spec 
                        sample.tmdarc"
        for f in ${tmda_contrib_doc}; do
                dodoc contrib/${f}     
        done
	dodoc COPYRIGHT ChangeLog README THANKS UPGRADE CRYPTO
}
