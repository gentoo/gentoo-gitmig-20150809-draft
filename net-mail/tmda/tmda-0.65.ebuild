# Copyright 2002 Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/tmda/tmda-0.65.ebuild,v 1.4 2003/09/05 02:32:14 msterret Exp $

DESCRIPTION="Python-based SPAM reduction system"
HOMEPAGE="http://www.tmda.net/"
LICENSE="GPL-2"

DEPEND=">=dev-lang/python-2.1
	virtual/mta"

SRC_URI="http://tmda.net/releases/${P}.tgz
	http://tmda.net/releases/old/${P}.tgz"

SLOT="0"
KEYWORDS="x86 sparc "

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
	insinto "/usr/lib/python${pv}/site-packages/TMDA/pythonlib/email"
	doins TMDA/pythonlib/email/*.py*

	# The templates
	insinto /etc/tmda
	doins templates/*.txt

	# Documentation
	dodoc COPYING ChangeLog README THANKS UPGRADE CRYPTO CODENAMES INSTALL
	dodoc contrib/tmda.spec contrib/sample.tmdarc
	dohtml -r htdocs/*.html

	# Contributed binaries and stuff
	cd contrib
	exeinto /usr/lib/tmda/bin
	doexe printcdb printdbm collectaddys def2html
	insinto /usr/lib/tmda/lisp
	doins tmda.el
}
