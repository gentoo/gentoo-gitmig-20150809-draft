# Copyright 2002 Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/tmda/tmda-0.59.ebuild,v 1.1 2002/08/06 22:32:48 agenkin Exp $

DESCRIPTION="Python-based SPAM reduction system"
HOMEPAGE="http://software.libertine.org/tmda/index.html"
LICENSE="GPL-2"

DEPEND=">=dev-lang/python-2.0
	virtual/mta"

SRC_URI="http://software.libertine.org/tmda/releases/${P}.tgz
	http://software.libertine.org/tmda/releases/old/${P}.tgz"

SLOT="0"
KEYWORDS="x86"

S="${WORKDIR}/${P}"

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
	doins TMDA/*.py*

	# The templates
	insinto /etc/tmda
	doins templates/*.txt
	
	# Documentation
	dodoc COPYRIGHT ChangeLog README THANKS UPGRADE CRYPTO
	dohtml -r htdocs/*.html

	# Contributed binaries and stuff
	cd contrib
	dodoc README.RELAY qmail-smtpd_auth.patch tmda.spec sample.tmdarc
	exeinto /usr/lib/tmda/bin
	doexe printcdb printdbm collectaddys
	insinto /usr/lib/tmda/lisp
	doins tmda.el
}
